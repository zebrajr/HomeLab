fs = require 'fs-plus'
{CompositeDisposable} = require 'atom'

MarkdownPreviewView = null
renderer = null

isMarkdownPreviewView = (object) ->
  MarkdownPreviewView ?= require './markdown-preview-view'
  object instanceof MarkdownPreviewView

module.exports =
  activate: ->
    @disposables = new CompositeDisposable()
    @commandSubscriptions = new CompositeDisposable()

    @disposables.add atom.config.observe 'markdown-it-preview.grammars', (grammars) =>
      @commandSubscription?.dispose()

      grammars ?= []
      grammars = grammars.map (grammar) -> grammar.replace(/\./g, ' ')
      for grammar in grammars
        @commandSubscription = atom.commands.add "atom-text-editor[data-grammar='#{grammar}']",
          'markdown-it-preview:toggle': =>
            @toggle()
          'markdown-it-preview:copy-html':
            displayName: 'Markdown Preview: Copy HTML'
            didDispatch: => @copyHTML()
          'markdown-it-preview:save-as-html':
            displayName: 'Markdown Preview: Save as HTML'
            didDispatch: => @saveAsHTML()

      return # Do not return the results of the for loop

    @disposables.add atom.commands.add 'atom-workspace',
      'markdown-it-preview:toggle': =>
        @toggle()
      'markdown-it-preview:copy-html': =>
        @copyHTML()
      'markdown-it-preview:save-as-html': =>
        @saveAsHTML()
      'markdown-it-preview:toggle-break-on-single-newline': ->
        keyPath = 'markdown-it-preview.breakOnSingleNewline'
        atom.config.set(keyPath, not atom.config.get(keyPath))
      'markdown-it-preview:toggle-github-style': ->
        keyPath = 'markdown-it-preview.useGitHubStyle'
        atom.config.set(keyPath, not atom.config.get(keyPath))

    previewFile = @previewFile.bind(this)
    for extension in ['markdown', 'md', 'mdown', 'mkd', 'mkdown', 'ron', 'txt']
      @disposables.add atom.commands.add ".tree-view .file .name[data-name$=\\.#{extension}]",
        'markdown-it-preview:preview-file', previewFile

    @disposables.add atom.workspace.addOpener (uriToOpen) =>
      [protocol, path] = uriToOpen.split('://')
      return unless protocol is 'markdown-it-preview'

      try
        path = decodeURI(path)
      catch
        return

      if path.startsWith 'editor/'
        @createMarkdownPreviewView(editorId: path.substring(7))
      else
        @createMarkdownPreviewView(filePath: path)

  deactivate: ->
    @disposables.dispose()
    @commandSubscriptions.dispose()

  createMarkdownPreviewView: (state) ->
    if state.editorId or fs.isFileSync(state.filePath)
      MarkdownPreviewView ?= require './markdown-preview-view'
      new MarkdownPreviewView(state)

  toggle: ->
    if isMarkdownPreviewView(atom.workspace.getActivePaneItem())
      atom.workspace.destroyActivePaneItem()
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    grammars = atom.config.get('markdown-it-preview.grammars') ? []
    return unless editor.getGrammar().scopeName in grammars

    @addPreviewForEditor(editor) unless @removePreviewForEditor(editor)

  uriForEditor: (editor) ->
    "markdown-it-preview://editor/#{editor.id}"

  removePreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previewPane = atom.workspace.paneForURI(uri)
    if previewPane?
      previewPane.destroyItem(previewPane.itemForURI(uri))
      true
    else
      false

  addPreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previousActivePane = atom.workspace.getActivePane()
    options =
      searchAllPanes: true
    if atom.config.get('markdown-it-preview.openPreviewInSplitPane')
      options.split = 'right'
    atom.workspace.open(uri, options).then (markdownPreviewView) ->
      if isMarkdownPreviewView(markdownPreviewView)
        previousActivePane.activate()

  previewFile: ({target}) ->
    filePath = target.dataset.path
    return unless filePath

    for editor in atom.workspace.getTextEditors() when editor.getPath() is filePath
      @addPreviewForEditor(editor)
      return

    atom.workspace.open "markdown-it-preview://#{encodeURI(filePath)}", searchAllPanes: true

  copyHTML: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    renderer ?= require './renderer'
    text = editor.getSelectedText() or editor.getText()
    renderer.toHTML text, editor.getPath(), editor.getGrammar(), (error, html) ->
      if error
        console.warn('Copying Markdown as HTML failed', error)
      else
        atom.clipboard.write(html)

  saveAsHTML: ->
    activePane = atom.workspace.getActivePaneItem()
    if isMarkdownPreviewView(activePane)
      activePane.saveAs()
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    grammars = atom.config.get('markdown-it-preview.grammars') ? []
    return unless editor.getGrammar().scopeName in grammars

    uri = @uriForEditor(editor)
    markdownPreviewPane = atom.workspace.paneForURI(uri)
    return unless markdownPreviewPane?

    previousActivePane = atom.workspace.getActivePane()
    markdownPreviewPane.activate()
    activePane = atom.workspace.getActivePaneItem()

    if isMarkdownPreviewView(activePane)
      activePane.saveAs().then ->
        previousActivePane.activate()
