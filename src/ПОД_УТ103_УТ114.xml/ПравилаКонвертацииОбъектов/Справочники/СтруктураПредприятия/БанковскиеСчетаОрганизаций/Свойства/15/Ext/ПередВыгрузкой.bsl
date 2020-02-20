﻿Запрос = Новый Запрос(
"ВЫБРАТЬ ПЕРВЫЕ 1
|	НастройкиОбменаСКлиентомБанка.Программа,
|	НастройкиОбменаСКлиентомБанка.Кодировка,
|	НастройкиОбменаСКлиентомБанка.ВидыВыгружаемыхПлатДокументов,
|	НастройкиОбменаСКлиентомБанка.ФайлЗагрузки,
|	НастройкиОбменаСКлиентомБанка.ФайлВыгрузки
|ИЗ
|	РегистрСведений.НастройкиОбменаСКлиентомБанка КАК НастройкиОбменаСКлиентомБанка
|ГДЕ
|	НастройкиОбменаСКлиентомБанка.БанковскийСчет = &БанковскийСчет
|");
Запрос.УстановитьПараметр("БанковскийСчет", Источник.Ссылка);

Выборка = Запрос.Выполнить().Выбрать();
Если Выборка.Следующий() Тогда
	Значение = Выборка.ФайлВыгрузки;	
КонецЕсли;
