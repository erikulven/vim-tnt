import json
from urllib import quote as uquote
from urllib import unquote as uunquote
from urllib import quote_plus as uquote_plus
from urllib import unquote_plus as uunquote_plus
import sqlparse
import vim


def fold_python_docstrings():
    b = vim.current.buffer
    end = len(b)
    vim.command("set foldmethod=manual")
    vim.command("set fml=0")
    start_fold = -1
    end_fold = -1
    for c in range(end):
        l = b[c].strip()
        if start_fold < 0 and (l.startswith('"""') or l.startswith("'''")):
            start_fold = c + 1
        elif start_fold >= 0 and (l.endswith('"""') or l.endswith("'''")):
            end_fold = c + 1
            vim.command("%s,%sfold" % (start_fold, end_fold))
            start_fold = end_fold = -1


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


def format_sql(sql_text):
    return sqlparse.format(sql_text, reindent=True).split('\n')


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
