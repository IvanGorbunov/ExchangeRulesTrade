﻿Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ВзаиморасчетыСКонтрагентамиОстатки.Организация КАК Организация,
	|	ВЫРАЗИТЬ(ВзаиморасчетыСКонтрагентамиОстатки.Сделка КАК Документ.ЗаказПоставщику) КАК ОбъектРасчетов,
	|	ВЫРАЗИТЬ(ВзаиморасчетыСКонтрагентамиОстатки.Сделка КАК Документ.ЗаказПоставщику).Дата КАК ДатаРасчетногоДокумента,
	|	ВЫРАЗИТЬ(ВзаиморасчетыСКонтрагентамиОстатки.Сделка КАК Документ.ЗаказПоставщику).Номер КАК НомерРасчетногоДокумента,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Контрагент                              КАК Контрагент,
	|	ВзаиморасчетыСКонтрагентамиОстатки.Контрагент                              КАК Партнер,
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаВзаиморасчетовОстаток              КАК Сумма,
	|	
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаВзаиморасчетовОстаток * ВЫБОР
	|		КОГДА ЕСТЬNULL(КурсыВалют.Курс, 0) > 0
	|				И ЕСТЬNULL(КурсыВалют.Кратность, 0) > 0
	|			ТОГДА КурсыВалют.Курс / КурсыВалют.Кратность
	|		ИНАЧЕ 0
	|	КОНЕЦ                                                                      КАК СуммаРегл,
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаУпрОстаток						   КАК СуммаУпр,
	|	ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.ВалютаВзаиморасчетов КАК ВалютаВзаиморасчетов
	|ИЗ
	|	РегистрНакопления.ВзаиморасчетыСКонтрагентами.Остатки(
	|			&ДатаОстатков,
	|			ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровКонтрагентов.СПоставщиком)
	|				И ДоговорКонтрагента.ВедениеВзаиморасчетов = ЗНАЧЕНИЕ(Перечисление.ВедениеВзаиморасчетовПоДоговорам.ПоЗаказам)
	|				И Сделка ССЫЛКА Документ.ЗаказПоставщику) КАК ВзаиморасчетыСКонтрагентамиОстатки
	|	
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(&ДатаОстатков) КАК КурсыВалют
	|		ПО ВзаиморасчетыСКонтрагентамиОстатки.ДоговорКонтрагента.ВалютаВзаиморасчетов = КурсыВалют.Валюта
	|	
	|ГДЕ
	|	ВзаиморасчетыСКонтрагентамиОстатки.СуммаВзаиморасчетовОстаток > 0
	|
	|УПОРЯДОЧИТЬ ПО
	|	Контрагент
	|ИТОГИ ПО
	|	Организация
	|АВТОУПОРЯДОЧИВАНИЕ");
	
Если Параметры.Организации.Количество() > 0 Тогда
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ", 
								"Организация В (&МассивОрганизаций) И ДоговорКонтрагента.ВидДоговора = ЗНАЧЕНИЕ");
	Запрос.УстановитьПараметр("МассивОрганизаций", Параметры.Организации);
КонецЕсли;	

Запрос.УстановитьПараметр("ДатаОстатков", КонецДня(Параметры.ДатаОстатков));

ВыборкаДанных = Новый ТаблицаЗначений;
ВыборкаДанных.Колонки.Добавить("Дата");
ВыборкаДанных.Колонки.Добавить("Организация");
ВыборкаДанных.Колонки.Добавить("РасчетыСПартнерами");

РезультатыЗапроса = Запрос.Выполнить();
ВыборкаПоОрганизациям = РезультатыЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
Пока ВыборкаПоОрганизациям.Следующий() Цикл
	
	НоваяСтрока = ВыборкаДанных.Добавить();
	НоваяСтрока.Дата        = КонецДня(Параметры.ДатаОстатков); 
	НоваяСтрока.Организация = ВыборкаПоОрганизациям.Организация; 
	
	РасчетыСПартнерами = Неопределено;
	Выполнить(Алгоритмы.ТаблицаРасчетовСПартнерами);
	НоваяСтрока.РасчетыСПартнерами = РасчетыСПартнерами;
	
	ВыборкаДетальныеЗаписи = ВыборкаПоОрганизациям.Выбрать(); 
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
		НоваяСтрокаРасчетыСПартнерами = НоваяСтрока.РасчетыСПартнерами.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаРасчетыСПартнерами, ВыборкаДетальныеЗаписи);
	
	КонецЦикла;
КонецЦикла;

Выполнить(Алгоритмы.ОчисткаВыборки);
