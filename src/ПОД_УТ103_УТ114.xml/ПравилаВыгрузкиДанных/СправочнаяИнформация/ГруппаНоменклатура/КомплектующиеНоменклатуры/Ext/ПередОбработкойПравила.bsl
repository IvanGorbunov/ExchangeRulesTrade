﻿Запрос = Новый Запрос("ВЫБРАТЬ
                      |	КомплектующиеНоменклатуры.Номенклатура КАК Владелец,
                      |	КомплектующиеНоменклатуры.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
                      |	КомплектующиеНоменклатуры.Комплектующая КАК Номенклатура,
                      |	КомплектующиеНоменклатуры.ХарактеристикаКомплектующей КАК Характеристика,
                      |	КомплектующиеНоменклатуры.Количество КАК КоличествоУпаковок,
                      |	КомплектующиеНоменклатуры.ЕдиницаИзмерения КАК Упаковка,
                      |	КомплектующиеНоменклатуры.ДоляСтоимости,
                      |	КомплектующиеНоменклатуры.Количество * КомплектующиеНоменклатуры.ЕдиницаИзмерения.Коэффициент КАК Количество
                      |ИЗ
                      |	РегистрСведений.КомплектующиеНоменклатуры КАК КомплектующиеНоменклатуры
                      |ИТОГИ ПО
                      |	Владелец,
                      |	ХарактеристикаНоменклатуры");
					  
					  
ВыборкаПоНоменклатуре = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);

ВыборкаДанных = Новый Массив;
Пока ВыборкаПоНоменклатуре.Следующий() Цикл
	
	ВыборкаПоХарактеристике = ВыборкаПоНоменклатуре.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаПоХарактеристике.Следующий() Цикл
		
		НовыйОбъектВыгрузки = Новый Структура();
		НовыйОбъектВыгрузки.Вставить("Владелец",		ВыборкаПоХарактеристике.Владелец);
		НовыйОбъектВыгрузки.Вставить("Наименование",	Строка(ВыборкаПоХарактеристике.Владелец));
		НовыйОбъектВыгрузки.Вставить("Характеристика",	ВыборкаПоХарактеристике.ХарактеристикаНоменклатуры);
		НовыйОбъектВыгрузки.Вставить("Основной",		Истина);
		НовыйОбъектВыгрузки.Вставить("ПометкаУдаления",	Ложь);
		
		Товары = Новый ТаблицаЗначений();
		Товары.Колонки.Добавить("ДоляСтоимости");
		Товары.Колонки.Добавить("Количество");
		Товары.Колонки.Добавить("КоличествоУпаковок");
		Товары.Колонки.Добавить("Номенклатура");
		Товары.Колонки.Добавить("Упаковка");
		Товары.Колонки.Добавить("Характеристика");
		
		ДетальнаяВыборка = ВыборкаПоХарактеристике.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ДетальнаяВыборка.Следующий() Цикл
			
			НоваяСтрока = Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ДетальнаяВыборка);
			
		КонецЦикла;
		
		НовыйОбъектВыгрузки.Вставить("Товары", Товары);
		ВыборкаДанных.Добавить(НовыйОбъектВыгрузки);
		
	КонецЦикла
	
КонецЦикла;
