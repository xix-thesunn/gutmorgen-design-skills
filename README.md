# GUTEN MORGEN Design Skills

Скилл [do-product-page](plugins/design-skills/skills/do-product-page/SKILL.md) описывает создание и обновление товарных карточек GUTEN MORGEN через Figma MCP Bridge и Higgsfield.

Скиллы распространяются одним пакетом Codex `design-skills@gutmorgen`. Проверочные скиллы возвращают маркеры версии по явному запросу.

## Установка

В локальном Codex можно написать «Установи плагин design-skills из https://github.com/xix-thesunn/gutmorgen-design-skills и проверь оба скилла». Команды для агента с доступом к GitHub и установленным Git:

```text
codex plugin marketplace add https://github.com/xix-thesunn/gutmorgen-design-skills.git
codex plugin add design-skills@gutmorgen
```

В новом чате попросите вызвать `gutmorgen-check-product-page` и `gutmorgen-check-banner`. Оба ответа должны содержать версию установленного пакета.

## Обновление

Вызови `gutmorgen-update`. Скилл покажет установленную версию, новую версию и патчноут из GitHub Releases. После твоего подтверждения Codex обновит весь пакет.

При переходе с версии 0.1.1, в которой скилла обновления ещё нет, выполни `codex plugin marketplace upgrade gutmorgen` и открой новый чат.

## Подготовка Figma MCP Bridge на Windows

Когда пользователь просит настроить Bridge, агент запускает `scripts/prepare-figma-bridge.ps1` из клона этого репозитория в локальной сессии Windows. Скрипт проверяет контрольную сумму официального архива gethopp и выводит абсолютный путь к `manifest.json`. Плагин сохраняется в системной папке «Документы», включая случай перенаправления в OneDrive, в подпапке `Figma MCP Bridge/v0.0.27`.

Агент проверяет `codex mcp get figma-bridge` и переиспользует рабочую настройку. Если записи нет и Node.js 20 или новее и npm доступны, регистрирует сервер соответствующей версии:

```powershell
codex mcp add figma-bridge -- cmd.exe /d /c npx -y @gethopp/figma-mcp-bridge@0.0.27
```

Если доступен интерфейс Figma Desktop, агент импортирует подготовленный манифест через меню `Plugins → Development → Import plugin from manifest` и запускает Bridge в указанном файле.

Если интерфейс недоступен или импорт не удалось завершить, агент сообщает, какие шаги выполнены, и показывает **абсолютный путь, возвращённый скриптом**, с короткой инструкцией:

1. Открой нужный файл в Figma Desktop.
2. Выбери `Plugins → Development → Import plugin from manifest` и укажи путь к `manifest.json` из ответа агента.
3. Запусти Figma MCP Bridge в этом файле.

После запуска в новой сессии Codex вызови `list_files` и проверь, что Bridge видит нужный файл. Если сервер не зарегистрирован, агент отдельно сообщает причину.

## Статус проверки

Установка набора из GitHub проверена на Windows для версии 0.1.0. Подготовка Bridge в версии 0.1.1 требует проверки в локальной Windows-сессии. Автоматическая установка Node.js, Higgsfield MCP и Portable Git в эту версию не входит.
