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

    xAxis = (m.background.width / 2) - (m.label.boundingRect().width/2)
    yAxis = (m.background.height / 2) - (m.label.boundingRect().height/2)
    
    m.label.translation = [xAxis, yAxis]
end sub

