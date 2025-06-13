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

![8_migration](https://github.com/user-attachments/assets/26755ee2-c82f-44e3-b0d7-06f671dc3c92)


11. Создайте отдельную ветку `feature/add_reply` в репозитории.

![9_branch](https://github.com/user-attachments/assets/a9d40a38-f96b-448e-82ad-faa9d61d0d54)

12. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
![10_hunter](https://github.com/user-attachments/assets/08159c74-6d74-4a0b-9fe7-a9fb91415d57)



13. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.

![11_test_hunter](https://github.com/user-attachments/assets/ff96ed20-40c3-4aab-bfef-504f065a37aa)

14. Сделайте push всех изменений в новую ветку репозитория.

![12_push](https://github.com/user-attachments/assets/f84cf797-c753-45ad-8527-17e0e10a3e38)

15. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.

![13_good_tests](https://github.com/user-attachments/assets/172d4f57-e537-43d6-9835-43b620e8b325)

16. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.

![14_merge](https://github.com/user-attachments/assets/7a884059-01d7-4459-98f0-51d205158341)

17. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.

![15no_artefact](https://github.com/user-attachments/assets/358164aa-703b-499b-b85d-14fc61497b67)

18. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.

![16_jar](https://github.com/user-attachments/assets/322f1fc4-e896-4fdf-8cf4-28c3cb7f732f)

19. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
![17_pass](https://github.com/user-attachments/assets/71594605-0cc8-47b0-9807-5be4283d937b)

![18_artefackt](https://github.com/user-attachments/assets/478213c2-c387-469f-b0f6-8fed9c73818b)

20. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.

![19_repo](https://github.com/user-attachments/assets/41a55424-0a09-4fff-90ac-14fe6023aafe)

21. В ответе пришлите ссылку на репозиторий.

[https://github.com/vakhtanov/netology-teamcity](https://github.com/vakhtanov/netology-teamcity)
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
