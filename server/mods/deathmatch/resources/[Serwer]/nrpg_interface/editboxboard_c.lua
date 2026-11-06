function isEventHandlerAdded(eventName, rootName, fnc)
    if type(eventName) == 'string' and isElement(rootName) and type(fnc) == 'function' then
      local eventHandlers = getEventHandlers(eventName, rootName)
      if type(eventHandlers) == 'table' and #eventHandlers > 0 then
        for i,v in ipairs(eventHandlers) do
          if v == fnc then
            return true
          end
        end
      end
    end
    return false
  end



local edit = false

function startPaste()
    edit = guiCreateEdit(3000, 3000, 200, 200, '', false, false)
    guiBringToFront(edit)

    removeEventHandler('onClientRender', root, paste_render)
    removeEventHandler('onClientKey', root, paste_key)

    addEventHandler('onClientRender', root, paste_render)
    addEventHandler('onClientKey', root, paste_key)
end

function paste_render()
    if (getKeyState('lctrl') or getKeyState('rctrl')) and getKeyState('v') then
        local text = guiGetText(edit) or ''
        setSelectedEditBoxTextImportant(text)
    end
end

function paste_key()
    if press and (getKeyState('lctrl') or getKeyState('rctrl')) and (getKeyState('c') or getKeyState('a')) then
        cancelEvent()
    end
end

function stopPaste()
    if edit and isElement(edit) then
        destroyElement(edit)
    end

    removeEventHandler('onClientRender', root, paste_render)
    removeEventHandler('onClientKey', root, paste_key)
end