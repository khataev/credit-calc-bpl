# README

Проект подключен к сервису непрерывной сборки - Travis-CI.org

{<img src="https://travis-ci.org/khataev/credit-calc-bpl.svg?branch=master" alt="Build Status" />}[https://travis-ci.org/khataev/credit-calc-bpl]

Демо https://credit-calc-bpl.herokuapp.com/

Тестовове задание: Калькулятор доходности по займу.
* Тесты на бизнес логику
* Глючные неказистые вьюхи, n+1 запросы, отсутствие rubocop'а - следствие сжатых сроков
* Расчет доходности производится при нажатии на кнопку Рассчитать параметры доходности, доступной при наличии погашенных траншей
* Заем -> Транши -> Погшения
