use lumos22;

-- Количество имейлов  - все имейлы исключая дубли. Дубли по имейлу(оставляем первую регистрацию, 
-- исключаем все повторные, выводим уникальное количество всех имейлов у которых дата регистрации раньше - колонка с датой - “created_at). 
-- Таблицы которые использовать - podio_hooks
SELECT count(*) as unique_emails FROM
(SELECT MIN(created_at) AS created_at, COUNT(email) AS email
FROM podio_hooks_
GROUP BY email) AS emails;

-- Количество оплат всего - количество оплат (все опталы у который в колонке “status” - “Получен”). 
-- Таблицы которые использовать - podio_payments
SELECT count(status) as success_payments FROM podio_payments where status='Получен';

-- Сумма оплат всего - сумма оплат всего  (все опталы у который в колонке “status” - “Получен” и суммировать по колонке “amount”). 
-- Таблицы которые использовать - podio_payments
SELECT SUM(amount) sum_payments FROM podio_payments where status='Получен';

-- Количество оплат от подписчиков (в эту колонку должны попасть все оплаты у которых  в колонке “status” - “Получен”,
-- которые при этом пересекаются по имейлу - смотреть обе таблицы. 
-- Таблицы которые использовать - podio_payments и podio_hooks
SELECT COUNT(*) AS subscribers_payments_count FROM
(
	SELECT podio_payments.status, podio_hooks_.email 
	FROM podio_payments 
	INNER JOIN podio_hooks_ 
	ON podio_payments.email = podio_hooks_.email 
	WHERE podio_payments.status = 'Получен'
) 
AS select_subscribers_payments_count;

-- Сумма оплат от подписчиков (в эту колонку должны попасть все оплаты у которых  в колонке “status” - “Получен”, 
-- которые при этом пересекаются по имейлу - смотреть обе таблицы, суммировать по колонке “amount” из таблицы podio_payments.
-- Таблицы которые использовать - podio_payments и podio_hooks
SELECT SUM(podio_payments.amount) as sum_payments_subscribers  
FROM podio_payments 
INNER JOIN podio_hooks_ 
ON podio_payments.email = podio_hooks_.email 
WHERE podio_payments.status = 'Получен';