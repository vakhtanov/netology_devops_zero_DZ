# Общие функции при написании скриптов
## Сканирование сети
утилита `arping` - обнаружение хостов в сети и проверка доступности\
`{1..10}` - генератор от 1 до 10\
`{1..10..2}` - генератор от 1 до 10 с шагом 2\
`trap 'DO_COMMAND' SIGNAL` - перехват сигналов  и выполнение команды. Действует на весь скрипт - удобно когда в цикле выполняется программа\
сигнал 2 - `ctrl+C`\
`kill -l` - список сигналов