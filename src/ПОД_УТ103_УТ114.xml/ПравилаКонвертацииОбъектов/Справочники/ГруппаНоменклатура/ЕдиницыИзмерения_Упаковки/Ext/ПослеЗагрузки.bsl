﻿Справочники.УпаковкиЕдиницыИзмерения.ОтработатьЛогикуСвязиРеквизитов(Объект);
Объект.Наименование = Справочники.УпаковкиЕдиницыИзмерения.СформироватьНаименование(Объект.ТипУпаковки, Объект.ЕдиницаИзмерения, Объект.Числитель, Объект.Знаменатель, Объект.Владелец.ЕдиницаИзмерения);

Если Не Объект.Владелец.ИспользоватьУпаковки = Истина Тогда
	ВладелецУпаковки = Объект.Владелец.ПолучитьОбъект();
	ВладелецУпаковки.ИспользоватьУпаковки = Истина;
	ВладелецУпаковки.Записать();
КонецЕсли;
