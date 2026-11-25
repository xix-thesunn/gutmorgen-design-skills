# GUT MORGEN Design Skills

Версия 0.1.0 проверяет распространение двух скиллов как одного плагина Codex `design-skills@gutmorgen`. Проверочные скиллы возвращают маркеры версии по явному запросу.

## Установка

В локальном Codex можно написать «Установи плагин design-skills из https://github.com/xix-thesunn/gutmorgen-design-skills и проверь оба скилла». Команды для агента с доступом к GitHub и установленным Git:

```text
codex plugin marketplace add https://github.com/xix-thesunn/gutmorgen-design-skills.git
codex plugin add design-skills@gutmorgen
```

В новом чате попросите вызвать `gutmorgen-check-product-page` и `gutmorgen-check-banner`. Оба ответа должны содержать версию установленного пакета.

## Обновление

Запрос «Обнови design-skills@gutmorgen из GitHub» соответствует команде:

```text
codex plugin marketplace upgrade gutmorgen
```

При выпуске обновления увеличивайте версию в манифесте плагина. Оба скилла распространяются одним пакетом из отслеживаемой ветки.

## Границы пробной версии

Установка и обновление файлов проверены через CLI на Linux с чистым профилем и локальным Git-источником. Для проверки на Windows нужен чистый профиль и тест установки из GitHub по текстовому запросу. Автоматическая настройка Higgsfield MCP, Figma MCP Bridge и Portable Git запланирована для следующего этапа. Для Bridge нужно определить точный источник и способ установки.
