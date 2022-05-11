import pandas as pd

""" Сохраняет результаты вычислений в csv-файл, выводит результат в stdout

Установка:

1. создать виртуальное окружение (опционально):
python -m venv venv

2. активировать виртуальное окружение, при условии выполнения п.1 (пример для 
Windows)
venv\sctipts\activate

3. Установить заисимости
Автоматически:
pip install -r requirements.txt
Вручную:
pip install pandas

4. запуск скрипта
python app.py

Результирующая таблица выводится на экран и сохраняется в csv-файле 
data/result.csv
"""

class DataSource:

    """ разделитель файла csv """
    delimiter = ','

    """ кодировка файлов csv """
    encoding = 'utf8'
    
    """ Заголовки таблиц, используемые в dataset-ах """
    header_email = 'email'
    
    header_email_lower = 'email_lower'

    header_account = 'account'

    header_status = 'status'

    header_amount = 'amount'


    def get_data(self, datasource) -> pd.DataFrame:
        """ Возвращает содержимое dataset-a

        Args:
            datasource (str): csv-файл dataset-a

        Returns:
            pd.DataFrame: dataframe, содержащий полный набор данных dataset-a
        """
        delimiter = self.delimiter
        encoding = self.encoding
        df = pd.read_csv(datasource, sep=delimiter, encoding=encoding)
        return df


class Payments(DataSource):

    """ файл данных """
    datasource = 'data/podio_payments.csv'

    """ Искомое значение столбца, используемое для фильтрации совершенных 
    оплат """
    success_payment_value = 'Получен'

    def get_payments(self) -> pd.DataFrame:
        """ возвращает набор данных таблицы payments

        Returns:
            pd.DataFrame: Таблица payments
        """
        datasource = self.datasource
        df = self.get_data(datasource)
        return df


    def get_success_payments(self) -> pd.DataFrame:
        """ Возвращает список успешных оплат (фильтрация по столбцу amount,
        значение - "Получен")

        Returns:
            pd.DataFrame: Список успешных оплат
        """
        df = self.get_payments()
        df = df[df[self.header_status]==self.success_payment_value]
        return df


    def get_success_payments_count(self) -> int:
        """ Возвращает количество успешных оплат

        Returns:
            int: Количество оплат
        """
        df = self.get_success_payments()
        return len(df)


    def get_payments_amount_summary(self) -> int:
        """ Возвращает сумму успешных оплат

        Returns:
            int: сумма успешных оплат
        """
        df = self.get_success_payments()
        amount = df[self.header_amount]
        amount = amount.apply(lambda row: row.replace('\xa0', ''))
        amount_summary = amount.astype(float).sum()
        return amount_summary


class Hooks(DataSource):


    """ файл данных """
    datasource = 'data/podio_hooks_.csv'
 
    
    def get_hooks(self) -> pd.DataFrame:
        """ Возвращает полный набор данных из файла dataset-a

        Returns:
            pd.DataFrame: Результирующий набор данных
        """
        datasource = self.datasource
        df = self.get_data(datasource)
        return df

    
    def get_unique_emails_count(self) -> int:
        """ возвращает список уникальных email-адресов

        Returns:
            int: Кол-во уникальных email-адресов
        """
        df_hooks = self.get_hooks()
        df_hooks = df_hooks.drop_duplicates(subset=Hooks.header_email_lower, \
            keep='first')
        return len(df_hooks)

    
class Stats:

    """ Результирующий файл """
    result_file = 'data/result.csv'

    """ Заголовки результирующего файла """
    emails_count = "Количество e-mail адресов"

    total_payments_count = "Количество оплат всего"

    total_payments_amount = "Сумма оплат всего"

    payments_count_from_subscribers = "Количество оплат от подписчиков"

    amount_payments_from_subscribers = "Сумма оплат от подписчиков"

    def __init__(self) -> None:
        self.payments = Payments()
        self.hooks = Hooks()

    def get_datasource_merged_by_email(self) -> pd.DataFrame:
        """ Объединяет таблицы по полю email

        Returns:
            pd.DataFrame: результирующий набор данных
        """
        df_payments = self.payments.get_data(Payments.datasource)
        df_hooks = self.hooks.get_data(Hooks.datasource)
        df_result = df_payments.merge(df_hooks, on=Payments.header_email, \
            how='inner')
        df_result = df_result[df_result[Payments.header_status] == \
            Payments.success_payment_value]
        return df_result


    def get_payments_count_subscribers(self) -> int:
        """ Возвращает количество оплат от подписчиков

        Returns:
            int: Количество оплат от подписчиков
        """
        df = self.get_datasource_merged_by_email()
        return len(df)

    
    def get_payments_amount_subscribers(self) -> int:
        """ Возвращает сумму оплат от подписчиков

        Returns:
            int: Сумма оплат от подписчиков
        """
        df = self.get_datasource_merged_by_email()
        amount = df[DataSource.header_amount]
        amount = amount.apply(lambda row: row.replace('\xa0', ''))
        amount_summary = amount.astype(float).sum()
        return amount_summary


    def get_result_dataframe(self) -> pd.DataFrame:
        """ Генерирует результирующий набор данных, выгружает в файл csv

        Returns:
            pd.DataFrame: результирующий набор данных
        """
        emails_count = self.hooks.get_unique_emails_count()
        payments_count = self.payments.get_success_payments_count()
        payments_amount = self.payments.get_payments_amount_summary()
        payments_count_subscribers = self.get_payments_count_subscribers()
        payments_amount_subscribers = self.get_payments_amount_subscribers()
        data = [{
            self.emails_count: emails_count, 
            self.total_payments_count: payments_count,
            self.total_payments_amount: payments_amount,
            self.payments_count_from_subscribers: payments_count_subscribers,
            self.amount_payments_from_subscribers: payments_amount_subscribers
        }]
        df = pd.DataFrame(data)
        df.to_csv(self.result_file, index=None)
        return df


if __name__ == "__main__":
    stats = Stats()
    df = stats.get_result_dataframe()
    print(df)