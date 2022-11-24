Live22View = require './live22-view'
{CompositeDisposable} = require 'atom'

module.exports = Live22 =
  live22View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @live22View = new Live22View(state.live22ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @live22View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'live22:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @live22View.destroy()

  serialize: ->
    live22ViewState: @live22View.serialize()

  toggle: ->
    console.log 'Live22 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
