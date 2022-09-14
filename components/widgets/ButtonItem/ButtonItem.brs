sub init()
    m.label = m.top.findNode("label")
    m.background = m.top.findNode("background")
    m.Focus = m.top.findNode("Focus")
end sub
 
sub onItemContentChanged(event)
    m.item = event.getData()
    m.label.text = m.item.TITLE

    if m.item.enable = false
        m.Focus.visible = true
        m.label.color = "#6F6E6E"
    end if

    m.background.width  = m.label.boundingRect().width + 40
    m.Focus.width  = m.label.boundingRect().width + 40

    xAxis = (m.background.width / 2) - (m.label.boundingRect().width/2)
    yAxis = (m.background.height / 2) - (m.label.boundingRect().height/2)
    
    m.label.translation = [xAxis, yAxis]
end sub

sub onItemFocusChanged()
    if m.item.enable = true
        if m.top.itemHasFocus = true
            m.Focus.visible = true
        else 
            m.Focus.visible = false
        end if
    end if
end sub
