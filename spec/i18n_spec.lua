describe('i18n', function()
  local i18n

  setup(function()
    local loader = require 'spec/loader'
    loader.load('i18n.lua')
    i18n = _G.EquipMe.i18n

    local enUS = i18n:register('enUS', 'English (US)', 'English (US)', true)
    local svSE = i18n:register('svSE', 'Svenska (Sverige)', 'Swedish (Sweden)')

    enUS['hello'] = 'Hello'
    svSE['hello'] = 'Hallå'

    enUS['greet'] = 'Hello, %s!'
    svSE['greet'] = 'Hallå, %s!'

    enUS['test_fallback'] = 'English fallback'
    enUS['test_fallback_format'] = 'Some %s'
  end)

  it('gets the correct default locale', function()
    assert.same('enUS', i18n:get().code)
  end)

  it('gets the correct specific locale', function()
    assert.same('svSE', i18n:get('svSE').code)
  end)

  it('gets a defined string in default locale', function()
    assert.same('Hello', i18n:get()['hello'])
  end)

  it('gets a defined string in non-default locale', function()
    assert.same('Hallå', i18n:get('svSE')['hello'])
  end)

  it('fallbacks to correct default locale', function()
    assert.same('English fallback', i18n:get('svSE')['test_fallback'])
  end)

  it('formats a string when called', function()
    assert.same('Hello, Foobar!', i18n:get()('greet', 'Foobar'))
  end)

  it('formats a string in non-default locale when called', function()
    assert.same('Hallå, Svensson!', i18n:get('svSE')('greet', 'Svensson'))
  end)

  it('formats a fallback string', function()
    assert.same('Some cheese', i18n:get('svSE')('test_fallback_format', 'cheese'))
  end)

  it('notifies about missing strings', function()
    assert.same('MISSING STRING: does_not_exist', i18n:get()['does_not_exist'])
  end)

  it('notifies about missing strings from non-default locale', function()
    local l = i18n:get('svSE')
    assert.same('MISSING STRING: does_not_exist', l['does_not_exist'])
  end)
end)