﻿Запрос = Новый Запрос("
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	1
	|ИЗ
	|	Справочник.ПричиныЗакрытияЗаказов
	|");

Значение = Не Запрос.Выполнить().Пустой();
