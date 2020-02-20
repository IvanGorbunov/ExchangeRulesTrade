﻿// Вычислим новое значение для порядка элемента
Информация = НастройкаПорядкаЭлементов.ПолучитьИнформациюДляПеремещения(Объект.Ссылка.Метаданные());
Если Объект.РеквизитДопУпорядочивания = 0 Тогда
	Объект.РеквизитДопУпорядочивания =
		НастройкаПорядкаЭлементовСлужебный.ПолучитьНовоеЗначениеРеквизитаДопУпорядочивания(
				Информация,
				?(Информация.ЕстьРодитель, Объект.Родитель, Неопределено),
				?(Информация.ЕстьВладелец, Объект.Владелец, Неопределено));
КонецЕсли;
