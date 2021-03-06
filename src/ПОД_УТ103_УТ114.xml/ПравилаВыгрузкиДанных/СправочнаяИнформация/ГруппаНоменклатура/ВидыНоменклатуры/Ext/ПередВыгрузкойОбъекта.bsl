﻿// Часть информации берем из первой попавшейся номенклатуры с указанным видом номенклатуры
Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
                      |	Номенклатура.Ссылка,
                      |	Номенклатура.ВестиУчетПоСериям
                      |ИЗ
                      |	Справочник.Номенклатура КАК Номенклатура
                      |ГДЕ
                      |	(НЕ Номенклатура.ЭтоГруппа)
                      |	И Номенклатура.ВидНоменклатуры = &ВидНоменклатуры");
Запрос.УстановитьПараметр("ВидНоменклатуры", Объект.Ссылка);
ВыборкаНоменклатуры = Запрос.Выполнить().Выбрать();

Если ВыборкаНоменклатуры.Следующий() Тогда
	
	Источник = ВыборкаНоменклатуры.Ссылка;
	Выполнить(Алгоритмы.ВходящиеДанныеНоменклатуры);
	
	Значение = Неопределено;
	СоздатьВидНоменклатуры_Номенклатура					= ВыборкаНоменклатуры.Ссылка;
	СоздатьВидНоменклатуры_НаименованиеВидаНоменклатуры = Объект.Наименование;
	СоздатьВидНоменклатуры_ТипНоменклатуры				= ВходящиеДанные.ТипНоменклатуры;
	СоздатьВидНоменклатуры_ИспользоватьСерии			= ВыборкаНоменклатуры.ВестиУчетПоСериям;
	СоздатьВидНоменклатуры_АлкогольнаяПродукция          = Ложь;
	СоздатьВидНоменклатуры_ИмпортнаяАлкогольнаяПродукция = Ложь;
	СоздатьВидНоменклатуры_ВидАлкогольнойПродукции       = Неопределено;
	Выполнить(Алгоритмы.СоздатьВидНоменклатуры);
	ВыгрузитьПоПравилу(Значение,,,, "ВидыНоменклатуры");
	
КонецЕсли;
