import random
import requests

import sentry_sdk

sentry_sdk.init(
    dsn="https://c46aa4a6dab725ceba803c17f8ef015e@o4509525536079872.ingest.de.sentry.io/4509525804515408",
    # Add data like request headers and IP for users,
    # see https://docs.sentry.io/platforms/python/data-management/data-collected/ for more info
    send_default_pii=True,
)

# URL общедоступного словаря (список английских слов)
url = "https://raw.githubusercontent.com/dwyl/english-words/master/words.txt"

# Загружаем слова
response = requests.get(url)
words = response.text.splitlines()

# Количество слов для вывода
num_words = 5

if __name__ == '__main__':
    for _ in range(num_words):
        print(random.choice(words))
    #issue1
    #print(some_text)
    ##issue2
    #rezult = 123/0
    #issue3
    #result = 123 + 1O
