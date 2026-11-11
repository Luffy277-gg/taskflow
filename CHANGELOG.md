# Changelog

Все значимые изменения проекта TaskFlow записываются в этот файл.

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/),
версии нумеруются по [семантическому версионированию](https://semver.org/lang/ru/).

> Версии 0.2.0 и 1.0.0 — план курса: они будут выпущены в следующих лабораторных работах, поэтому даты у них плановые.

## [1.0.0] - 2026-12-25

### Added
- Регистрация и вход: `POST /auth/register`, `POST /auth/login`.
- Авторизация по токену для всех эндпоинтов задач.
- Dockerfile и docker-compose.yml для запуска в контейнере.
- Деплой приложения в облако.

### Changed
- Все эндпоинты `/tasks` теперь требуют токен доступа.

### Security
- Пароли хранятся только в виде хеша (bcrypt).

## [0.2.0] - 2026-12-01

### Added
- CRUD для задач: `GET /tasks`, `POST /tasks`, `GET /tasks/{id}`, `PUT /tasks/{id}`, `DELETE /tasks/{id}`.
- Модель Task в SQLAlchemy и подключение базы SQLite.
- Фильтрация задач по статусу: `GET /tasks?status=open`.

### Changed
- README.md дополнен списком эндпоинтов.

## [0.1.0] - 2026-11-10

### Added
- Начальная структура проекта: папка `taskflow`.
- Схема базы данных `schema.sql` (таблицы users, projects, tasks, comments).
- Документация: README.md, CHANGELOG.md, API.md.
- Пример функции с docstring: `example.py`.
