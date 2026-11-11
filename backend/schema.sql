-- TaskFlow: схема базы данных (SQLite)
-- Основа: ответ YandexGPT (Алиса), проверен по чек-листу ЛР № 2 и исправлен:
--   1) добавлено поле users.role (роли admin/user из ТЗ ЛР № 1);
--   2) статусы задач приведены к ТЗ: open / in_progress / done (было todo);
--   3) projects.owner_id: ON DELETE RESTRICT вместо CASCADE —
--      удаление пользователя не должно молча удалять его проекты;
--   4) добавлено поле tasks.updated_at.
-- Файл пока не запускается, он понадобится в ЛР № 8.

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    username      TEXT    NOT NULL UNIQUE COLLATE NOCASE,
    email         TEXT    NOT NULL UNIQUE COLLATE NOCASE,
    password_hash TEXT    NOT NULL,
    role          TEXT    NOT NULL DEFAULT 'user'
                  CHECK (role IN ('user', 'admin')),
    created_at    TEXT    NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE projects (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description TEXT,
    owner_id    INTEGER NOT NULL,
    created_at  TEXT    NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (owner_id) REFERENCES users (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE tasks (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT    NOT NULL,
    description TEXT,
    status      TEXT    NOT NULL DEFAULT 'open'
                CHECK (status IN ('open', 'in_progress', 'done')),
    priority    TEXT    NOT NULL DEFAULT 'medium'
                CHECK (priority IN ('low', 'medium', 'high')),
    project_id  INTEGER NOT NULL,
    assignee_id INTEGER,
    created_at  TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at  TEXT,
    deadline    TEXT,
    FOREIGN KEY (project_id) REFERENCES projects (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (assignee_id) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE comments (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    task_id    INTEGER NOT NULL,
    author_id  INTEGER NOT NULL,
    text       TEXT    NOT NULL,
    created_at TEXT    NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (task_id) REFERENCES tasks (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Индексы на внешние ключи (SQLite сам их не создаёт)
CREATE INDEX idx_projects_owner  ON projects (owner_id);
CREATE INDEX idx_tasks_project   ON tasks (project_id);
CREATE INDEX idx_tasks_assignee  ON tasks (assignee_id);
CREATE INDEX idx_tasks_deadline  ON tasks (deadline) WHERE deadline IS NOT NULL;
CREATE INDEX idx_comments_task   ON comments (task_id);
CREATE INDEX idx_comments_author ON comments (author_id);
