sub init()
    m.ButtonTask = CreateObject("roSGNode", "ButtonTask")
    m.ButtonTask.observeField("output", "onButtonInfoReady")
    m.ButtonTask.control = "RUN" 
    m.backgroundPoster = m.top.findNode("backgroundPoster")
    m.buttonRowList = m.top.findNode("buttonRowList")
    m.screenTitle = m.top.findNode("screenTitle")
    m.topButton = m.top.findNode("topButton")
    m.rowList = m.top.findNode("rowList")
    initRowList()
    _initObservers()
end sub

sub initRowList()
    rowListContent = CreateObject("roSGNode", "RowListContent")
    for each itemContent in rowListContent.getChild(0).getChildren(rowListContent.getChild(0).getChildCount(), 0)
        itemContent.addField("itemFocused", "boolean", false)
        itemContent.itemFocused = false
    end for
    m.rowList.content = rowListContent
end sub

sub _initObservers()
    m.top.observeField("focusedChild", "initFocus")
    m.topButton.observeField("buttonSelected", "showDialog")
    m.rowList.observeField("rowItemFocused", "onRowItemFocused")
    m.rowList.observeField("focusedChild", "onRowListFocusChange")
    m.buttonRowList.observeField("rowItemSelected", "onRowItemSelected")
end sub

sub onButtonInfoReady(event)
    m.buttonRowList.content = event.getData()
end sub


sub initFocus()
    if m.top.visible = true AND m.top.isInFocusChain()
        if NOT m.topButton.hasFocus()
            m.topButton.setFocus(true)
            m.top.unobserveField("focusedChild")
        end if
    end if
end sub

function buttonPanelConfig()
    buttonsConfig = {
            
        visuals : {
            A : ["one", "two", "three", "four", "five"]
            B : ["one", "two", "three", "four", "five", "six", "seven", "eight"]
            C : ["one", "two", "three", "four", "five", "six", "seven", "eight", "one", "two", "three", "four", "five", "six", "seven", "eight"]
        }
    }
    return buttonsConfig
end function

sub showdialog()
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = "Buttons Panel mode"
    dialog.optionsDialog = true
    dialog.message = "Select the desired buttons panel mode"
    dialog.buttons = ["A", "B", "C"]
    dialog.observeField("buttonSelected", "onDialogButtonSelected")
    m.top.GetScene().dialog = dialog
end sub

sub onRowItemSelected(event)
    indexPositions = event.getData() 
    content = m.buttonRowList.content.getChild(indexPositions[0]).getChild(indexPositions[1])
    m.screenTitle.text = content.TITLE
end sub

sub onDialogButtonSelected(event as Object)
    option = event.getData().toStr()
    m.top.GetScene().dialog = invalid

    availableOptions = {
        "0": "A"
        "1": "B"
        "2": "C"
    }

    m.top.selectedOption = availableOptions[option]
end sub

sub onRowItemFocused(event as Object)
    row = event.getData()[0]
    index = event.getData()[1]

    content = m.rowList.content.getChild(row).getChild(index)
    m.backgroundPoster.uri = content.HDPOSTERURL

    rowContent = m.rowList.content.getChild(row)

    for i = 0 to rowContent.getChildCount() - 1
        itemContent = rowContent.getChild(i)
        if i = index
            itemContent.itemFocused = true
        else
            itemContent.itemFocused = false
        end if
    end for
end sub

sub onRowListFocusChange()
    if NOT m.rowList.isInFocusChain()
        for i = 0 to m.rowList.content.getChildCount() - 1
            rowContent = m.rowList.content.getChild(i)
            for j = 0 to rowContent.getChildCount() - 1
                itemContent = rowContent.getChild(j)
                itemContent.itemFocused = false
            end for
        end for
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
      if (key = "down")
        if m.topButton.hasFocus()
            m.buttonRowList.setFocus(true)
        else if m.buttonRowList.isInFocusChain()
            m.rowList.setFocus(true)
        end if

      else if (key = "up")
        if m.rowList.isInFocusChain()
            m.buttonRowList.setFocus(true)
        else if m.buttonRowList.isInFocusChain()
            m.topButton.setFocus(true)
        end if
    '  else if (key = "OK" and m.topButton.hasFocus())
      end if
    end if 
    return handled
  end function