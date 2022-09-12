sub init()
    m.ButtonItem = m.top.findNode("ButtonItem")
    m.top.observeField("focusedChild", "onFocusedChanged")
    m.top.observeField("itemContent", "onItemContentChanged")
end sub

sub onFocusedChanged(event)
    if m.top.isInFocusChain()
  '   textFont="font:SmallBoldSystemFont"
   '  focusFootprintBitmapUri = "pkg:/images/Button.png"
    else 
 '    focusedTextFont = "font:SmallBoldSystemFont"
  '   focusFootprintBitmapUri = "pkg:/images/Button-Unfocused.png"
    end if
end sub
 
sub onItemContentChanged(event)
    item = event.getData()
    m.ButtonItem.text = item.TITLE
    m.ButtonItem.width = "180"
   ' m.ButtonItem.maxWidth = item.TITLE.boundingRect().width 

    'xAxis = (m.ButtonItem.width / 2) - (item.TITLE.boundingRect().width / 2)
   ' yAxis = (m.ButtonItem.height / 2) - (item.TITLE.boundingRect().height / 2)
    
   ' m.ButtonItem.translation = [xAxis, yAxis]
end sub

