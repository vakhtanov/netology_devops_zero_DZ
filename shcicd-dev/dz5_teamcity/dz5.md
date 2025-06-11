# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
2. Дождитесь запуска teamcity, выполните первоначальную настройку.
3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
4. Авторизуйте агент.
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).
6. Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure).

![1VMS](https://github.com/user-attachments/assets/d2a4a0a4-91cb-4844-bbbb-bcebe1371ac2)


## Основная часть

1. Создайте новый проект в teamcity на основе fork.

![project](https://github.com/user-attachments/assets/18bce7a7-897f-483a-b1b4-47b12d76fe79)

  
2. Сделайте autodetect конфигурации.

![3autocnf](https://github.com/user-attachments/assets/0a035e50-fa6c-43fa-82f7-e7edb151289c)


3. Сохраните необходимые шаги, запустите первую сборку master.

![4_1build](https://github.com/user-attachments/assets/a48c9a72-1bb4-413f-a92a-a925f3422961)


4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.

![5_steps](https://github.com/user-attachments/assets/fcce98b4-145e-4d8e-8074-23bd1d6ec0c2)

6. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.

7. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
8. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.

![6_2build](https://github.com/user-attachments/assets/454dfb8b-ada3-4d09-b022-b6e3ec149752)
![7_nexus](https://github.com/user-attachments/assets/97dd7513-0115-4495-b200-e0ba9300e557)


9. Мигрируйте `build configuration` в репозиторий.
10. Создайте отдельную ветку `feature/add_reply` в репозитории.
11. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
12. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
13. Сделайте push всех изменений в новую ветку репозитория.
14. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
15. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
16. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
17. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
18. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
19. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
20. В ответе пришлите ссылку на репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
