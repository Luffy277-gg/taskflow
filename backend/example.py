def get_tasks(tasks, status=None, priority=None):
    """
    Фильтрует список задач по статусу и приоритету, затем сортирует их по дате создания.

    Данная функция итеративно проходит по переданному списку задач, применяя опциональные
    фильтры. Если параметры `status` или `priority` не указаны (равны None), соответствующий
    фильтр пропускается. Отфильтрованный список сортируется по ключу 'created_at' в
    возрастающем порядке (от самых старых к новым).

    Args:
        tasks (list): Список словарей, где каждый словарь представляет собой задачу.
            Ожидается, что каждая задача содержит ключи 'status', 'priority' и 'created_at'.
        status (str, optional): Статус для фильтрации ('open', 'in_progress' или 'done').
            Если None, фильтрация по статусу не применяется. По умолчанию None.
        priority (str, optional): Приоритет для фильтрации ('low', 'medium' или 'high').
            Если None, фильтрация по приоритету не применяется. По умолчанию None.

    Returns:
        list: Новый список задач, отфильтрованный по заданным критериям и отсортированный
        по времени создания.
    """
    # Инициализируем пустой список для хранения задач, прошедших фильтрацию
    result = []

    # Проходим по каждой задаче из входящего списка
    for task in tasks:
        # Если передан фильтр по статусу и статус текущей задачи не совпадает с фильтром,
        # пропускаем текущую итерацию и переходим к следующей задаче
        if status is not None and task["status"] != status:
            continue

        # Если передан фильтр по приоритету и приоритет текущей задачи не совпадает с фильтром,
        # пропускаем текущую итерацию и переходим к следующей задаче
        if priority is not None and task["priority"] != priority:
            continue

        # Если задача прошла все проверки (или фильтры не были заданы),
        # добавляем её в результирующий список
        result.append(task)

    # Сортируем итоговый список задач по значению ключа 'created_at' (дате создания)
    # в прямом хронологическом порядке
    result.sort(key=lambda t: t["created_at"])

    # Возвращаем отсортированный и отфильтрованный список задач
    return result


# Проверка: запускается командой python example.py
if __name__ == "__main__":
    demo = [
        {"title": "Написать README", "status": "done", "priority": "low", "created_at": "2026-11-10 10:00:00"},
        {"title": "Схема БД", "status": "open", "priority": "high", "created_at": "2026-11-08 09:00:00"},
        {"title": "Эндпоинт GET /tasks", "status": "open", "priority": "medium", "created_at": "2026-11-09 15:30:00"},
    ]
    print("Все задачи:")
    for t in get_tasks(demo):
        print(" ", t["created_at"], t["status"], t["priority"], t["title"])
    print("Только открытые:")
    for t in get_tasks(demo, status="open"):
        print(" ", t["created_at"], t["status"], t["priority"], t["title"])
    print("Открытые с высоким приоритетом:")
    for t in get_tasks(demo, status="open", priority="high"):
        print(" ", t["created_at"], t["status"], t["priority"], t["title"])
