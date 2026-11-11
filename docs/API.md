# TaskFlow API

Базовый адрес: `http://127.0.0.1:5000`. Формат данных — JSON.

Все эндпоинты, кроме регистрации и входа, требуют заголовок:

```
Authorization: Bearer <token>
```

Допустимые значения полей задачи:

- `status`: `open`, `in_progress`, `done`
- `priority`: `low`, `medium`, `high`

## Авторизация

### POST /auth/register

Регистрация нового пользователя.

Тело запроса:

```json
{ "username": "artem", "email": "artem@example.com", "password": "S3curePass!" }
```

Ответ (201 Created):

```json
{ "id": 1, "username": "artem", "email": "artem@example.com", "role": "user" }
```

Ошибки: `409` — имя или email уже заняты; `422` — не заполнено обязательное поле.

### POST /auth/login

Вход и получение токена.

Тело запроса:

```json
{ "email": "artem@example.com", "password": "S3curePass!" }
```

Ответ (200 OK):

```json
{ "token": "eyJhbGciOi...", "user": { "id": 1, "username": "artem", "role": "user" } }
```

Ошибки: `401` — неверный email или пароль.

## Задачи

### GET /tasks

Список задач. Фильтры в строке запроса: `status`, `priority`, `project_id`, `assignee_id`.

Тело запроса: нет.

Пример: `GET /tasks?status=open&priority=high`

Ответ (200 OK):

```json
[
  {
    "id": 1,
    "title": "Спроектировать схему БД",
    "description": "Таблицы users, projects, tasks, comments",
    "status": "open",
    "priority": "high",
    "project_id": 1,
    "assignee_id": 1,
    "created_at": "2026-11-10 12:00:00",
    "deadline": "2026-11-20 18:00:00"
  }
]
```

### POST /tasks

Создание задачи в проекте.

Тело запроса:

```json
{
  "title": "Спроектировать схему БД",
  "description": "Таблицы users, projects, tasks, comments",
  "project_id": 1,
  "assignee_id": 1,
  "priority": "high",
  "deadline": "2026-11-20 18:00:00"
}
```

Ответ (201 Created):

```json
{ "id": 1, "title": "Спроектировать схему БД", "status": "open", "priority": "high", "project_id": 1 }
```

Ошибки: `404` — проект не найден; `422` — нет `title` или недопустимый `priority`.

### GET /tasks/{id}

Одна задача по идентификатору.

Тело запроса: нет.

Ответ (200 OK):

```json
{
  "id": 1,
  "title": "Спроектировать схему БД",
  "status": "open",
  "priority": "high",
  "project_id": 1,
  "assignee_id": 1,
  "deadline": "2026-11-20 18:00:00"
}
```

Ошибки: `404` — задача не найдена.

### PUT /tasks/{id}

Полная замена данных задачи.

Тело запроса:

```json
{
  "title": "Спроектировать схему БД",
  "description": "Схема проверена по чек-листу",
  "status": "done",
  "priority": "high",
  "assignee_id": 1,
  "deadline": "2026-11-20 18:00:00"
}
```

Ответ (200 OK):

```json
{ "id": 1, "title": "Спроектировать схему БД", "status": "done", "priority": "high" }
```

Ошибки: `403` — нет прав на задачу; `404` — задача не найдена; `422` — недопустимый `status`.

### DELETE /tasks/{id}

Удаление задачи вместе с её комментариями.

Тело запроса: нет.

Ответ (204 No Content): тело пустое.

Ошибки: `403` — нет прав на задачу; `404` — задача не найдена.

## Коды ответов

| Код | Когда возвращается |
|---|---|
| 200 | запрос выполнен |
| 201 | объект создан |
| 204 | объект удалён |
| 401 | нет токена или он недействителен |
| 403 | недостаточно прав |
| 404 | объект не найден |
| 409 | конфликт данных |
| 422 | данные не прошли проверку |
