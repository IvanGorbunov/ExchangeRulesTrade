﻿КоллекцияОбъектов = Новый ТаблицаЗначений;

КоллекцияОбъектов.Колонки.Добавить("Количество");
КоллекцияОбъектов.Колонки.Добавить("Номенклатура");
КоллекцияОбъектов.Колонки.Добавить("СтавкаНДС");
КоллекцияОбъектов.Колонки.Добавить("Сумма");
КоллекцияОбъектов.Колонки.Добавить("СуммаНДС");
КоллекцияОбъектов.Колонки.Добавить("Цена");
КоллекцияОбъектов.Колонки.Добавить("КоличествоУпаковок");
КоллекцияОбъектов.Колонки.Добавить("Характеристика");
// КоллекцияОбъектов.Колонки.Добавить("ВариантОбеспечения");
// КоллекцияОбъектов.Колонки.Добавить("ДатаОтгрузки");
КоллекцияОбъектов.Колонки.Добавить("Серия");
// КоллекцияОбъектов.Колонки.Добавить("Склад");
// КоллекцияОбъектов.Колонки.Добавить("СтатусУказанияСерий");

Запрос = Новый Запрос;
Запрос.Текст = "
|ВЫБРАТЬ
|	ЗаказТовары.ЕдиницаИзмерения,
|	ЗаказТовары.Количество,
|	ЗаказТовары.Количество КАК КоличествоУпаковок,
|	ЗаказТовары.КоличествоМест,
|	ЗаказТовары.Коэффициент,
|	ЗаказТовары.СтавкаНДС,
|	ЗаказТовары.Сумма,
|	ЗаказТовары.СуммаНДС,
|	ЗаказТовары.ХарактеристикаНоменклатуры КАК Характеристика,
|	ЗаказТовары.Цена,
|	ЗаказТовары.Номенклатура КАК Номенклатура
|ИЗ
|	Документ.ЗаказПоставщику.Товары КАК ЗаказТовары
|ГДЕ
|	ЗаказТовары.Ссылка = &Заказ";
Запрос.УстановитьПараметр("Заказ", Источник.Ссылка);
//|
//|ОБЪЕДИНИТЬ ВСЕ
//|
//|ВЫБРАТЬ
//|	NULL,
//|	ЗаказПокупателяВозвратнаяТара.Количество,
//|	ЗаказПокупателяВозвратнаяТара.Количество,
//|	NULL,
//|	NULL,
//|	ЗНАЧЕНИЕ(Перечисление.СтавкиНДС.НДС18),
//|	ЗаказПокупателяВозвратнаяТара.Сумма,
//|	0.18 * ЗаказПокупателяВозвратнаяТара.Сумма,
//|	NULL,
//|	ЗаказПокупателяВозвратнаяТара.Цена,
//|	NULL,
//|	ЗаказПокупателяВозвратнаяТара.Номенклатура,
//|	ЗаказПокупателяВозвратнаяТара.Размещение
//|ИЗ
//|	Документ.ЗаказПокупателя.ВозвратнаяТара КАК ЗаказПокупателяВозвратнаяТара
//|
//|ОБЪЕДИНИТЬ ВСЕ
//|
//|ВЫБРАТЬ
//|	NULL,
//|	ЗаказПокупателяУслуги.Количество,
//|	ЗаказПокупателяУслуги.Количество,
//|	NULL,
//|	NULL,
//|	ЗаказПокупателяУслуги.СтавкаНДС,
//|	ЗаказПокупателяУслуги.Сумма,
//|	ЗаказПокупателяУслуги.СуммаНДС,
//|	NULL,
//|	ЗаказПокупателяУслуги.Цена,
//|	NULL,
//|	ЗаказПокупателяУслуги.Номенклатура,
//|	NULL
//|ИЗ
//|	Документ.ЗаказПокупателя.Услуги КАК ЗаказПокупателяУслуги";

Выборка = Запрос.Выполнить().Выбрать();
Пока Выборка.Следующий() Цикл
	ЗаполнитьЗначенияСвойств(КоллекцияОбъектов.Добавить(), Выборка);
КонецЦикла;
