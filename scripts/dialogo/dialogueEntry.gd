extends MarginContainer

@onready var _text: RichTextLabel = $VBoxContainer/RichTextLabel

"Ancient Reptilian Brain – Like a fly to the ointment, your conscience sticks to it. The limbed and headed machine of pain and undignified suffering is firing up again. It wants to walk the desert. Hurting. Longing. Dancing to disco music.
Volition [Passive Pass Medium 10] – You can take it, you're a Champion!
You – Mother, help me, there's a head attached to my neck and I'm *in* it.
Limbic System – The stench of liquor rises from your mouth. And with it -- an *un-godly* headache.
You – Help! Someone! Cut my head off, it's trying to murder the rest of me!
Limbic System – A fiery streak penetrates your skull, trying to force your eyes open. It's a sound. A clarion call from hell."


# https://www.youtube.com/watch?v=oimMfjTE5mM 21:48

func SetContent(speaker : Speaker, text : String, passiveCheck: String ="")->void:
	
	var speakerInfo = "[color=#%s]%s[/color]%s — " %\
	[
		speaker.color.to_html(),
		speaker.name.to_upper(),
		"" if passiveCheck == "" else "[color=#0f0]%s[/color]" % passiveCheck
	] 
	
	var content = "%s%s" %[speakerInfo, text]
	_text.text = content
	
	if _text.get_line_count() < 1:
		return
	
	await get_tree().process_frame
	
	var lineBreackPos = _text.get_line_range(0).y
	
	#lineBreackPos = lineBreackPos - speakerInfo.length()
	
	var textWithLineIndent = text.insert(lineBreackPos, "[indent][indent]")
	
	_text.text = "%s%s" %[
		speakerInfo,
		textWithLineIndent
	]
	




#var speaker = "Volition"
#var check = "[Passive Pass Medium 10]"
#var text = "Like a fly to the ointment, your conscience sticks to it. The limbed and headed machine of pain and undignified suffering is firing up again. It wants to walk the desert. Hurting. Longing. Dancing to disco music."
#
#var prefix = speaker + check + " — "
#var rawText = prefix + text
#
#field.text = rawText
#
#await get_tree().process_frame # wait one frame so values are calculated
#
#var lineBreackPos = field.get_line_range(0).y
#lineBreackPos = lineBreackPos - prefix.length()
#
#var textWithLineIndent = text.insert(lineBreackPos, "[indent]")
#
#field.text = "%s — %s" %[
	#"[color=#c9a646ff]%s[/color] [color=#636056]%s[/color]" % [speaker, check], 
	#textWithLineIndent
#]
