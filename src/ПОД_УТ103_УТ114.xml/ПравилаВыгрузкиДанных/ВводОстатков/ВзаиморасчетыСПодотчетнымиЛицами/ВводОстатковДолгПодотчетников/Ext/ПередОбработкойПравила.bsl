﻿Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.Организация                        КАК Организация,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.ФизЛицо                            КАК ПодотчетноеЛицо,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент                  КАК РасчетныйДокумент,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент.Номер            КАК НомерРасчетногоДокумента,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент.Дата             КАК ДатаРасчетногоДокумента,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.СуммаВзаиморасчетовОстаток         КАК Сумма,
	|	
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.СуммаВзаиморасчетовОстаток * ВЫБОР
	|		КОГДА ЕСТЬNULL(КурсыВалют.Курс, 0) > 0
	|				И ЕСТЬNULL(КурсыВалют.Кратность, 0) > 0
	|			ТОГДА КурсыВалют.Курс / КурсыВалют.Кратность
	|		ИНАЧЕ 0
	|	КОНЕЦ                                                                      КАК СуммаРегл,
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.СуммаУпрОстаток					   КАК СуммаУпр,
	|	
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.Валюта                             КАК Валюта
	|	
	|ИЗ
	|	РегистрНакопления.ВзаиморасчетыСПодотчетнымиЛицами.Остатки(&ДатаОстатков) КАК ВзаиморасчетыСПодотчетнымиЛицамиОстатки
	|	
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(&ДатаОстатков) КАК КурсыВалют
	|		ПО ВзаиморасчетыСПодотчетнымиЛицамиОстатки.Валюта = КурсыВалют.Валюта
	|	
	|ГДЕ
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент ССЫЛКА Документ.РасходныйКассовыйОрдер
	|		ИЛИ ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент ССЫЛКА Документ.ПриходныйКассовыйОрдер ИЛИ
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент ССЫЛКА Документ.ПлатежныйОрдерСписаниеДенежныхСредств
	|		ИЛИ ВзаиморасчетыСПодотчетнымиЛицамиОстатки.РасчетныйДокумент ССЫЛКА Документ.ПлатежноеПоручениеИсходящее
	|	
	|УПОРЯДОЧИТЬ ПО
	|	ВзаиморасчетыСПодотчетнымиЛицамиОстатки.ФизЛицо
	|ИТОГИ ПО
	|	Организация
	|АВТОУПОРЯДОЧИВАНИЕ");

Если Параметры.Организации.Количество() > 0 Тогда
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "и(&ДатаОстатков)", 
								"и(&ДатаОстатков, Организация В (&МассивОрганизаций))");
	Запрос.УстановитьПараметр("МассивОрганизаций", Параметры.Организации);
КонецЕсли;

Запрос.УстановитьПараметр("ДатаОстатков", КонецДня(Параметры.ДатаОстатков));

ВыборкаДанных = Новый ТаблицаЗначений;
ВыборкаДанных.Колонки.Добавить("Дата");
ВыборкаДанных.Колонки.Добавить("Организация");
ВыборкаДанных.Колонки.Добавить("РасчетыСПодотчетниками");

РезультатыЗапроса = Запрос.Выполнить();
ВыборкаПоОрганизациям = РезультатыЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
Пока ВыборкаПоОрганизациям.Следующий() Цикл
	
	НоваяСтрока = ВыборкаДанных.Добавить();
	НоваяСтрока.Дата        = КонецДня(Параметры.ДатаОстатков); 
	НоваяСтрока.Организация = ВыборкаПоОрганизациям.Организация; 
	
	НоваяСтрока.РасчетыСПодотчетниками = Новый ТаблицаЗначений;
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("ПодотчетноеЛицо");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("ДатаРасчетногоДокумента");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("НомерРасчетногоДокумента");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("Сумма");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("СуммаРегл");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("СуммаУпр");
	НоваяСтрока.РасчетыСПодотчетниками.Колонки.Добавить("Валюта");
	
	ВыборкаДетальныеЗаписи = ВыборкаПоОрганизациям.Выбрать(); 
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Если ВыборкаДетальныеЗаписи.Сумма < 0 Тогда
			СтрокаСообщения = НСтр("ru = 'Обнаружен отрицательный остаток по подотчетному лицу ""%1"" при выгрузке по правилу: ""%2""'");
			СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%1", ВыборкаДетальныеЗаписи.ПодотчетноеЛицо);
			СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%2", НСтр("ru = 'Долги подотчетников'"));
			ЗаписатьВПротоколВыполнения(СтрокаСообщения,,Ложь);
			Продолжить;
		КонецЕсли;
		Если ТипЗнч(ВыборкаДетальныеЗаписи.РасчетныйДокумент) = Тип("ДокументСсылка.ПриходныйКассовыйОрдер") Тогда
			СтрокаСообщения = НСтр("ru = 'Обнаружен остаток по расчетному документу вида ""Приходный кассовый ордер""
										 |по подотчетному лицу ""%1"" при выгрузке по правилу: ""%2""'");
			СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%1", ВыборкаДетальныеЗаписи.ПодотчетноеЛицо);
			СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%2", НСтр("ru = 'Долги подотчетников'"));
			ЗаписатьВПротоколВыполнения(СтрокаСообщения,,Ложь);
			Продолжить;
		КонецЕсли;
		
		НоваяСтрокаРасчетыСПодотчетниками = НоваяСтрока.РасчетыСПодотчетниками.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаРасчетыСПодотчетниками, ВыборкаДетальныеЗаписи);
				
	КонецЦикла;
	
	Если НоваяСтрока.РасчетыСПодотчетниками.Количество() = 0 Тогда
		ВыборкаДанных.Удалить(НоваяСтрока);
	КонецЕсли;
	
КонецЦикла;
