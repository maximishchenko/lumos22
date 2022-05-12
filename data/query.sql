use lumos22;


SELECT 
	-- Запрос уникальных email-адресов
	-- Возможно использовать DISTINCT, приведенное решение использовано, 
	-- т.к. в ТЗ указано ориентироваться на дату в столбце created_at
	(
		SELECT 
			COUNT(*)
		FROM
		(
			SELECT 
				MIN(created_at) AS created_at, COUNT(email) AS email
			FROM
				podio_hooks_
			GROUP BY 
				email
		) AS emails
	) AS 'Кол-во email-адресов',
	-- Запрос количества оплат всего
	(
		SELECT 
			COUNT(amount)
		FROM 
			podio_payments 
		WHERE 
			status='Получен'
	) AS 'Кол-во оплат всего',
	-- Запрос суммы оплат всего
	(
		SELECT 
			SUM(amount)
		FROM 
			podio_payments 
		WHERE 
			status='Получен'
	) AS 'Сумма оплат всего',
	-- Запрос количества оплат от подписчиков
	COUNT(podio_payments.email) AS 'Кол-во оплат от подписчиков',
	-- Запрос суммы оплат от подписчиков
	SUM(podio_payments.amount) AS 'Сумма оплат от подписчиков'
FROM 
	podio_payments 
INNER JOIN 
	podio_hooks_ 
ON 
	podio_payments.email = podio_hooks_.email 
WHERE 
	podio_payments.status = 'Получен';