sub init()
    m.label = m.top.findNode("label")
    m.background = m.top.findNode("background")
    m.Focus = m.top.findNode("Focus")
    m.top.observeField("focusedChild", "onFocusedChanged")
end sub

sub onFocusedChanged(event)
    if m.top.isInFocusChain()
        m.Focus.visible = true
    else 
        m.Focus.visible = false
    end if
end sub
 
sub onItemContentChanged(event)
    item = event.getData()
    m.label.text = item.TITLE

    if item.enable = false
        m.Focus.visible = true
        m.label.color = "#6F6E6E"
    end if

    m.background.width  = m.label.boundingRect().width + 40
    m.Focus.width  = m.label.boundingRect().width + 40

    xAxis = (m.background.width / 2) - (m.label.boundingRect().width/2)
    yAxis = (m.background.height / 2) - (m.label.boundingRect().height/2)
    
    m.label.translation = [xAxis, yAxis]
end sub

