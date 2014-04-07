import json
from urllib import quote as uquote
from urllib import unquote as uunquote
from urllib import quote_plus as uquote_plus
from urllib import unquote_plus as uunquote_plus
import vim


def selected_text():
    try:
        return vim.eval("SelectedText()")
    except:
        return None


def actual_text():
    """Return text actual for 'something'"""
    res = selected_text()
    if res is None:
        res = ''.join(vim.current.buffer[:])
    return res


def format_json(js_text):
    res = json.loads(js_text)
    return json.dumps(res, sort_keys=True, indent=4).split('\n')


def quote(s):
    """calls urllib.quote, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uquote(s.encode('utf-8'))
        else:
            return uquote(s)
    return None


def quote_plus(s):
    """calls urllib.quote_plus, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uquote_plus(s.encode('utf-8'))
        else:
            return uquote_plus(s)
    return None


def unquote(s):
    """calls urllib.unquote, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uunquote(s.encode('utf-8'))
        else:
            return uunquote(s)
    return None


def unquote_plus(s):
    """calls urllib.unquote_plus, if unicode it converts to utf-8. """
    if s is not None:
        if isinstance(s, unicode):
            return uunquote_plus(s.encode('utf-8'))
        else:
            return uunquote_plus(s)
    return None


def expand_identifier_naive(identifier):
    """Expands identifier to directories."""
    res = []
    for c in identifier:
        res.append(c)
        res.append('/')
    res.append(identifier)
    return ''.join(res)


def expand_identifier(identifier):
    """Expands identifier to directories."""
    res = []
    for c in identifier.decode('utf8'):
        res.append(enc_spec_char(c))
        res.append('/')
    ids = [enc_spec_char(c) for c in identifier.decode('utf8')]
    res.append(''.join(ids))
    return ''.join(res)


def enc_spec_char(c):
    if c:
        if c.isdigit() or c.isalpha():
            return c
        else:
            return "__%s__" % str(ord(c))
    return None
