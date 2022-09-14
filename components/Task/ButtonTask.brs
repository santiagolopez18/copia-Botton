sub init()
    m.top.functionName = "requestButtons"
end sub

sub requestButtons()
    response = ParseJson(ReadAsciiFile("pkg:/config/Buttons.json"))

    content = createObject("roSGNode", "ContentNode")

    section = content.createChild("ContentNode")
    

    for each button in response.buttons
        
            if button.visible = true
                item = createObject("roSGNode","ContentNode")
                item.title = button.labels.default
                item.addFields({"enable": button.enable})
                section.appendChild(item)

                if section.getChildCount()=5
                    section = content.createChild("ContentNode")
                end if 
            end if 
            
    end for

        
    m.top.output = content

end sub 
