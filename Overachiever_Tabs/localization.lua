
OVERACHIEVER_STRINGS_SEARCH_TAB = "Search";
OVERACHIEVER_STRINGS_SEARCH_HELP = "Use this tab to search for achievements. You can also search for achievements by name or ID using slash commands. See Overachiever's readme.txt file for details.";
OVERACHIEVER_STRINGS_SEARCH_NAME = "Name:";
OVERACHIEVER_STRINGS_SEARCH_DESC = "Description:";
OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "Criteria:";
OVERACHIEVER_STRINGS_SEARCH_REWARD = "Reward:";
OVERACHIEVER_STRINGS_SEARCH_ANY = "Any of the above:";
OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "Search all achievements";
OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "Include in the search achievements that aren't normally listed in the default UI, such as those exclusive to the opposing faction, unacquired Feats of Strength, etc.";
OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "Search";
OVERACHIEVER_STRINGS_SEARCH_RESET = "Reset";
OVERACHIEVER_STRINGS_SEARCH_RESULTS = "Found %s |4achievement:achievements;.";

OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "Suggestions";
OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "Suggested achievements are listed here based on your current location. Also listed are any achievements you were reminded about through a tooltip within the last 2 minutes.";
OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "Refresh";
OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "Overachiever has no suggestions for you at this time.";
OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "%d |4suggestion:suggestions; found.";
--OVERACHIEVER_STRINGS_SUGGESTIONS_INFO = "This section is still in development. Currently, only incomplete exploration achievements for the current zone are listed, but much more will be considered in future releases.";

OVERACHIEVER_STRINGS_TAB_SORT = "Sort by:";
OVERACHIEVER_STRINGS_TAB_SORT_NAME = "Name";
OVERACHIEVER_STRINGS_TAB_SORT_ID = "ID";
OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "Point value";
OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "Date completed";
OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl-click|r on an achievement to jump to its place in the standard UI.|n|nA |cffffffffblue background|r means it is part of a series for which you haven't completed an earlier step.|n|nA |cffffffffred background|r means it cannot be found in the standard UI for this character because it is exclusive to the opposing faction or is an unacquired Feat of Strength.|n|nA |cffffffffgreen background|r means a reminder about this achievement was displayed in a tooltip recently.";

if (GetLocale() == "deDE") then  -- German
	OVERACHIEVER_STRINGS_SEARCH_ANY = "In allen suchen";
	OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "Kriterium";
	OVERACHIEVER_STRINGS_SEARCH_DESC = "Beschreibung:";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "In allen Erfolgen suchen";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "Auch in Achievements suchen, die normal nicht aufgelistet werden. Wie z. B. welche der gegnerischen Fraktion, unerreichte Heldentaten, usw.";
	OVERACHIEVER_STRINGS_SEARCH_HELP = "Nutze diese Seite um Achievements zu suchen. Per Slash-Command kannst du auch nach Achievement-Name oder ID suchen. Lese dazu die readme.txt für Details.";
	OVERACHIEVER_STRINGS_SEARCH_NAME = "Name:";
	OVERACHIEVER_STRINGS_SEARCH_RESET = "Zurücksetzen";
	OVERACHIEVER_STRINGS_SEARCH_RESULTS = "%s |4Achievement:Achievements; gefunden.";
	OVERACHIEVER_STRINGS_SEARCH_REWARD = "Belohnung:";
	OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "Suche";
	OVERACHIEVER_STRINGS_SEARCH_TAB = "Suche";
	OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "Overachiever hat zur Zeit keine Vorschläge für dich.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "Hier werden Achievements aufgelistet, die du in deiner aktuellen Zone abschließen kannst. Es werden auch alle Achievemts aufgelistet an die du in den letzen 2 Minuten per Tooltip erinnert wurdest.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "Aktualisieren";
	OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "%d |4Vorschlag:Vorschläge; gefunden.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "Vorschläge";
	OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl-klick|r auf ein Achievement um es in der Standard UI anzuzeigen.|n|nEin |cffffffffblauer Hintergrund|r bedeutet das Achievement ist Teil einer Serie, bei welcher dir noch ein vorheriger Schritt fehlt.|n|nEin |cffffffffroter Hintergrund|r bedeutet das Achievement kann nicht im Standard UI gefunden werden, weil es nur von der Gegnerischen Fraktion erlangt werden kann oder eine unerreichtes Heldtentat ist.|n|nEin |cffffffffgüner Hintergrund|r zeigt an, daß du kürzlich im Tooltip an dieses Achievement erinnert wurdest.";
	OVERACHIEVER_STRINGS_TAB_SORT = "Sortieren nach:";
	OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "abgeschlossen am";
	OVERACHIEVER_STRINGS_TAB_SORT_ID = "ID";
	OVERACHIEVER_STRINGS_TAB_SORT_NAME = "Name";
	OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "Punktwert";

elseif (GetLocale() == "frFR") then  -- French
	--OVERACHIEVER_STRINGS_SEARCH_TAB
	--OVERACHIEVER_STRINGS_SUGGESTIONS_TAB

elseif (GetLocale() == "zhTW") then  -- Traditional Chinese
	OVERACHIEVER_STRINGS_SEARCH_ANY = "以上皆可:"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "條件:"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_DESC = "描述:"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "搜索所有成就"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "包括所有成就,已完成的,未完成的,無法完成的,等等."; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_HELP = "使用此標籤來搜索成就。您也可以使用命令搜索成就的名稱或編號。見 Overachiever 的 Readme.txt 文件的相關內容。"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_NAME = "名稱:"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_RESET = "重置"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_RESULTS = "搜索到 %s |4achievement:個成就;."; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_REWARD = "獎勵:"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "搜索"; -- Needs review
	OVERACHIEVER_STRINGS_SEARCH_TAB = "搜索"; -- Needs review
	OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "Overachiever 不建議在這個時候."; -- Needs review
	OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "建議完成當前 UI 所列出的成就."; -- Needs review
	OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "刷新"; -- Needs review
	-- OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "";
	OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "建議"; -- Needs review
	OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl + 點選|r 所選成就會跳轉到該成就的頁面.|n|n |cffffffff藍色背景|r表示此成就是你還沒有完成前續內容的系列成就部分.|n|n |cffffffff紅色背景|r表示此成就無法在你當前人物的標準成就界面中找到,因為這是陣營專屬成就,或者是你尚未取得的『光輝事跡』成就.";
	OVERACHIEVER_STRINGS_TAB_SORT = "類型:"; -- Needs review
	OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "完成時間"; -- Needs review
	-- OVERACHIEVER_STRINGS_TAB_SORT_ID = "";
	OVERACHIEVER_STRINGS_TAB_SORT_NAME = "名稱"; -- Needs review
	OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "點值"; -- Needs review

elseif (GetLocale() == "zhCN") then  -- Simplified Chinese
	OVERACHIEVER_STRINGS_SEARCH_ANY = "以上所有：";
	OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "条件：";
	OVERACHIEVER_STRINGS_SEARCH_DESC = "描述：";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "搜索所有成就";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "包括没有在默认列表中显示的成就，例如阵营专属成就、‘光辉事迹’成就等。";
	OVERACHIEVER_STRINGS_SEARCH_HELP = "使用这个标签来搜索成就。你也可以通过斜杠命令用名字或ID来搜索成就。详细请参见Overachiever的readme.txt文件。";
	OVERACHIEVER_STRINGS_SEARCH_NAME = "名字：";
	OVERACHIEVER_STRINGS_SEARCH_RESET = "重置";
	OVERACHIEVER_STRINGS_SEARCH_RESULTS = "找到 %s |4成就:成就;.";
	OVERACHIEVER_STRINGS_SEARCH_REWARD = "奖励：";
	OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "搜索";
	OVERACHIEVER_STRINGS_SEARCH_TAB = "搜索";
	OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "Overachiever现在没有任何建议。";
	OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "根据你的当前位置建议追踪成就。"; -- Needs review
	OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "刷新";
	OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "找到 %d |4成就:成就;.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "建议";
	OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl-点击|r一个成就跳转到它在标准成就界面的位置。|n|n |cffffffff蓝色背景|r表示此成就是你还没有完成前续内容的系列成就。|n|n |cffffffff红色背景|r表示此成就无法在当前人物的标准成就界面中找到，因为这是阵营专属成就，或是无法取得的‘光辉事迹’成就。|n|n  |cffffffff绿色背景|r 是提醒此成就最近在鼠标提示中显示过。"; -- Needs review
	OVERACHIEVER_STRINGS_TAB_SORT = "按……排序：";
	OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "完成时间";
	OVERACHIEVER_STRINGS_TAB_SORT_ID = "成就ID";
	OVERACHIEVER_STRINGS_TAB_SORT_NAME = "名字";
	OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "成就点数";

elseif (GetLocale() == "ruRU") then  -- Russian
	OVERACHIEVER_STRINGS_SEARCH_ANY = "Всё перечисленное:";
	OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "Критерий:";
	OVERACHIEVER_STRINGS_SEARCH_DESC = "Описание:";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "Искать по всем достижениям";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "В поиск будут включаться все достижения, включая не представленные в стандартном интерфейсе (например, достижения для противоположной фракции или невыполнимые).";
	OVERACHIEVER_STRINGS_SEARCH_HELP = "Воспользуйтесь этой вкладкой для поиска достижений. Вы также можете искать достижения по имени или номеру, используя команды часа. Более подробную информацию вы найдёте в файле readme.txt в папке аддона.";
	OVERACHIEVER_STRINGS_SEARCH_NAME = "Имя:";
	OVERACHIEVER_STRINGS_SEARCH_RESET = "Сбросить";
	OVERACHIEVER_STRINGS_SEARCH_RESULTS = "Найдено достижений: %s.";
	OVERACHIEVER_STRINGS_SEARCH_REWARD = "Награда:";
	OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "Поиск";
	OVERACHIEVER_STRINGS_SEARCH_TAB = "Поиск";
	OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "В данный момент подходящих достижений не обнаружено.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "Предпологаемые достижения, указанные здесь, основаны на вашем текущем местоположении. Также здесь могут находиться достижения, ";
	OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "Обновить";
	OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "Найдено предполагаемых достижений: %d.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "Предположения";
	OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl+левый клик|r на достижении перенаправит вас к его местоположению в стандартном интерфейсе.|n|n|cffffffffСиний фон|r означает, что это часть серии достижений, для которой вы ещё не выполнили предыдущий шаг.|n|n|cffffffffКрасный фон|r означает, что это достижение не может быть найдено в стандартном интерфейсе, так оно эксклюзивно для противоположной фракции или невыполнимо по какой-либо причине.|n|n|cffffffffЗелёный фон|r означает, что совсем недавно вы встречали объект, необходимый для этого достижения.";
	OVERACHIEVER_STRINGS_TAB_SORT = "Сортировать по:";
	OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "дате завершения";
	OVERACHIEVER_STRINGS_TAB_SORT_ID = "номеру";
	OVERACHIEVER_STRINGS_TAB_SORT_NAME = "имени";
	OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "очкам";

elseif (GetLocale() == "esES") then  -- Spanish
-- Thanks to user PatoDaia at wowinterface.com for these translations:
	OVERACHIEVER_STRINGS_SEARCH_ANY = "Cualquiera de los anteriores:";
	OVERACHIEVER_STRINGS_SEARCH_CRITERIA = "Requisitos:";
	OVERACHIEVER_STRINGS_SEARCH_DESC = "Descripción:";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST = "Buscar en todos los logros";
	OVERACHIEVER_STRINGS_SEARCH_FULLLIST_TIP = "Incluye en la búsqueda de logros aquellos que normalmente no aparecen en el interface por defecto, como aquellos exclusivos de la facción contraria, Logros de fuerza sin conseguir, etc.";
	OVERACHIEVER_STRINGS_SEARCH_HELP = "Usa esta pestaña para buscar logros. También puedes usar los comandos de chat para buscar logros por nombre o ID. Lee el archivo readme.txt de Overachiever para más detalles.";
	OVERACHIEVER_STRINGS_SEARCH_NAME = "Nombre:";
	OVERACHIEVER_STRINGS_SEARCH_RESET = "Limpiar";
	OVERACHIEVER_STRINGS_SEARCH_RESULTS = "|4Encontrado:Encontrados; %s |4logro:logros;.";
	OVERACHIEVER_STRINGS_SEARCH_REWARD = "Recompensa:";
	OVERACHIEVER_STRINGS_SEARCH_SUBMIT = "Buscar";
	OVERACHIEVER_STRINGS_SEARCH_TAB = "Búsqueda";
	OVERACHIEVER_STRINGS_SUGGESTIONS_EMPTY = "Overachiever no tiene sugerencias para tí en este momento.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_HELP = "Las sugerencias de logros aquí listados se basan en tu ubicación actual. También se lista cualquier logro del cual se te ha mostrado un tooltip recordatorio en los últimos dos minutos.";
	OVERACHIEVER_STRINGS_SUGGESTIONS_REFRESH = "Refrescar";
	OVERACHIEVER_STRINGS_SUGGESTIONS_RESULTS = "%d |4sugerencia:sugerencias; |4encontrada:encontradas;";
	OVERACHIEVER_STRINGS_SUGGESTIONS_TAB = "Sugerencias";
	OVERACHIEVER_STRINGS_TAB_HELP = "|cffffffffCtrl-click|r sobre un logro para saltar a su posición en el interface estándar.|n|nUn |cfffffffffondo azul|r indica que es parte de una serie para la que aún no has completado un paso anterior.|n|nUn |cfffffffffondo rojo|r indica que no se encuentra en el interface estándar para este personaje porque es exclusivo de la facción contraria o es una Proeza de fuerza que aún no has logrado.|n|nUn |cfffffffffondo verde|r indica que se ha mostrado un tooltip recordatorio sobre este logro recientemente.";
	OVERACHIEVER_STRINGS_TAB_SORT = "Ordenado por:";
	OVERACHIEVER_STRINGS_TAB_SORT_COMPLETE = "Fecha de finalización";
	OVERACHIEVER_STRINGS_TAB_SORT_ID = "ID";
	OVERACHIEVER_STRINGS_TAB_SORT_NAME = "Nombre";
	OVERACHIEVER_STRINGS_TAB_SORT_POINTS = "Puntuación";
end
