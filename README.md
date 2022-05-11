# Задача:
Сравнение таблиц на предмет пересечения данных по e-mail, формирование сводной таблицы со следующими столбцами:

 - Количество email  - все email исключая дубли.
 Используемые таблицы - podio_hooks

 - Количество оплат всего - количество оплат (все оплаты у которых в колонке "status" - "Получен").
 Используемые таблицы - podio_payments

 - Общая сумма оплат - суммировать по колонке "amount" все оплаты у которых в колонке "status" - "Получен". 
 Используемые таблицы  - podio_payments

 - Количество оплат от подписчиков (в эту колонку должны попасть все оплаты у которых  в столбце "status" - "Получен", которые при этом пересекаются по email - смотреть обе таблицы)s.
 Используемые таблицы - podio_payments и podio_hooks

 - Сумма оплат от подписчиков (в эту колонку должны попасть все оплаты у которых  в столбце "status" - "Получен", которые при этом пересекаются по email - смотреть обе таблицы, суммировать по колонке "amount" из таблицы podio_payments.
 Используемые таблицы - podio_payments и podio_hooks

# Исходные таблицы:
[hooks](data/podio_hooks_.csv)
[payments](data/podio_payments.csv)

# Результат
> выводится на экран в эмуляторе терминала и сохраняется в файле [result.csv](data/result.csv)

# Установка

1. Создать виртуальное окружение (опционально, в примере - venv)
```
python -m venv venv
```

2. Активировать виртуальное окружение в случае выполенния п.1 (в примере - для Windows)
```
venv\scripts\activate
```

3. Установить зависимости (автоматически или вручную)
- автоматически:
```
pip install -r requirements
```
- вручную:
```
pip install pandas
```

4. запуск скрипта
```
python app.py
```