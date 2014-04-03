import json


def format_json(js_text):
    res = json.loads(js_text)
    return json.dumps(res, sort_keys=True, indent=4).split('\n')
