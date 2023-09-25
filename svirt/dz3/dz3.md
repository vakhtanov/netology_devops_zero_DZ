# Домашнее задание к занятию «Docker. Часть 1»

Это задание для самостоятельной отработки навыков и не предполагает обратной связи от преподавателя. Его выполнение не влияет на завершение модуля. Но мы рекомендуем его выполнить, чтобы закрепить полученные знания.

### Задание 1  

1. Установите [Docker](https://www.docker.com/).
   ![1docker_install](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/9bc9576e-a976-432d-bf5a-948ba02fd6ae)

1. Запустите образ hello-world.
   ![2run_hello](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/7cd7193f-c5d7-4f9b-b8d2-866d07d7d890)

1. Удалите образ hello-world.

   ![3rm_hello](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/c61fead4-d101-482f-b853-cdab5826b7f6)


### Задание 2

1. Найдите в Docker Hub образ Apache и запустите его на 80 порту вашей ВМ.
![4_search_appache](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/477eb6ca-4c2d-4072-8330-d0f4dc7da650)
![5_appache_run](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/40dac74e-0ffb-41c3-b562-81ab605553d4)
   
3. Откройте страницу http://localhost и убедитесь, что видите приветвенную страницу Apache.
![6_run](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/915e9618-7657-47c0-9325-57d0f3225064)


   
### Задание 3

1. Создайте свой Docker образ с Apache2 и подмените стандартную страницу index.html на страницу, содержащую ваши ФИО.
![8_dockerfile](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/f347c71a-2301-471a-9c14-5ab2b4fa4c55)
![9_build](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/5d0a67b3-e816-4f5d-b5ae-d9579de3a9ea)
![10_run_cont](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/1e60c981-4f82-46f1-bf4b-9da3362c610f)

  
3. Запустите ваш образ, откройте страницу http://localhost и убедитесь, что страница изменилась.
![11_test](https://github.com/vakhtanov/netology_devops_zero_DZ/assets/26109918/51eeee5d-f5a2-4208-bf5d-762dd25e22c6)

   
