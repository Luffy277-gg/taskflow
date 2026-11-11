# TaskFlow — REST API менеджера задач

![Python](https://img.shields.io/badge/python-3.11%2B-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

TaskFlow — учебный REST API для управления проектами и задачами. Пользователи создают проекты, ставят в них задачи с исполнителем, статусом, приоритетом и сроком и обсуждают задачи в комментариях.

## Стек технологий

- **Язык:** Python 3.11+
- **Фреймворк:** Flask
- **ORM:** SQLAlchemy
- **База данных:** SQLite

## Установка и запуск

1. Перейдите в папку проекта:
```bash
cd taskflow
```
2. Создайте виртуальное окружение и установите зависимости одной командой:
```bash
./setup.sh
```
3. Запустите приложение:
```bash
# Windows, Git Bash
venv/Scripts/python.exe backend/app.py
# Linux или macOS
venv/bin/python backend/app.py
```

После запуска список задач доступен по адресу http://127.0.0.1:5000/tasks.

> База данных подключается в лабораторной работе № 8. Схема таблиц уже лежит в файле `backend/schema.sql`.

## Документация API

Все эндпоинты, тела запросов и примеры ответов описаны в файле [docs/API.md](docs/API.md).

Основные эндпоинты:

| Метод | URL | Описание |
|---|---|---|
| POST | `/auth/register` | регистрация |
| POST | `/auth/login` | вход и получение токена |
| GET | `/tasks` | список задач |
| POST | `/tasks` | создание задачи |
| GET | `/tasks/{id}` | одна задача |
| PUT | `/tasks/{id}` | изменение задачи |
| DELETE | `/tasks/{id}` | удаление задачи |

## Структура проекта

```
taskflow/
├── backend/          # серверная часть
│   ├── app.py        # Flask-приложение, маршрут GET /tasks
│   ├── config.py     # настройки (будут заполнены позже)
│   ├── models.py     # модели данных (ЛР № 8)
│   ├── routes.py     # маршруты API (ЛР № 9)
│   ├── schema.sql    # схема базы данных SQLite
│   └── example.py    # пример функции с docstring
├── frontend/         # клиентская часть (ЛР № 16)
├── docs/             # документация
│   ├── API.md        # описание эндпоинтов
│   ├── example.yaml  # пример данных в YAML
│   └── example.xml   # пример данных в XML
├── tests/            # тесты (ЛР № 15)
├── setup.sh          # создание venv и установка зависимостей
├── requirements.txt  # зависимости Python
├── CHANGELOG.md      # история версий
└── README.md         # этот файл
```

## История версий

См. [CHANGELOG.md](CHANGELOG.md).

## Лицензия

Проект распространяется под лицензией MIT.
