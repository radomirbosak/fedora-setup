#!/usr/bin/python3

import re
import json
import errno
from subprocess import PIPE, check_output

from ansible.module_utils.basic import AnsibleModule


def check_name(name):
    if name is None:
        raise Exception('Name cannot be None.')


def check_value(value):
    if value is None:
        raise Exception('Value cannot be None.')


def to_type(value, vartype):
    if vartype == 'json':
        return json.loads(value)
    elif vartype == 'int':
        return int(value)
    elif vartype == 'str':
        return str(value)
    elif vartype == 'bool':
        booldict = {
            'true': True,
            'True': True,
            'yes': True,
            'false': False,
            'False': False,
            'no': False,
        }
        return booldict.get(value, bool(value))
    else:
        raise ValueError('Unknown type')


def remove_key(json_dict, vartype, name, value=None, check_mode=False):
    # check if the name is valid
    check_name(name)

    # it the abbreviation doesn't exist don't delete anything
    if name not in json_dict:
        return False

    # if target value is specified, but it doesn't match the real value
    # don't do anything
    if value is not None and json_dict[name] != to_type(value, vartype):
        return False

    # delete the abbreviation with name 'name'
    if not check_mode:
        del json_dict[name]
    return True


def add_key(json_dict, vartype, name, value, check_mode=False):
    # check if the name is valid
    check_name(name)
    check_value(value)

    # if the abbreviation exists and has the correct value, don't
    # do anything
    realvalue = to_type(value, vartype)
    if name in json_dict and json_dict[name] == realvalue:
        return False

    # add or replace the abbreviation
    if not check_mode:
        json_dict[name] = realvalue
    return True


def read_dict(filename):
    try:
        file_cont = open(filename, 'r').read()
    except (OSError, IOError) as e: # FileNotFoundError does not exist on Python < 3.3
        if getattr(e, 'errno', 0) == errno.ENOENT:
            return {}

    file_cont = re.sub('//.*\n', '', file_cont)
    return json.loads(file_cont)


def write_dict(filename, json_dict):
    with open(filename, 'w') as f:
        json.dump(json_dict, f, indent=4, sort_keys=True)


def main():
    module = AnsibleModule(
        argument_spec=dict(
            state=dict(default='present', choices=['present', 'absent']),
            name=dict(required=True, type='str'),
            file=dict(required=True, type='str'),
            type=dict(required=True, type='str',
                      choices=['int', 'str', 'json', 'bool']),
            value=dict(type='str'),
        ),
        supports_check_mode=True,
    )

    name, value, filename, state, vartype = [
        module.params[prop]
        for prop in ['name', 'value', 'file', 'state', 'type']]

    json_dict = read_dict(filename)

    if state == 'absent':
        changed = remove_key(json_dict, vartype, name, value,
                             check_mode=module.check_mode)
    elif state == 'present':
        changed = add_key(json_dict, vartype, name, value,
                          check_mode=module.check_mode)

    if changed and not module.check_mode:
        write_dict(filename, json_dict)

    module.exit_json(changed=changed)


if __name__ == '__main__':
    main()
