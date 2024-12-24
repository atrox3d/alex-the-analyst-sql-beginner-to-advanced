import json
from pathlib import Path
from webbrowser import get


SECRETS_PATH = '.secrets'


def get_password(
        password_filename:str='password.txt',
        secrets_path:str=SECRETS_PATH
) -> str:
    password_path = Path(secrets_path, password_filename)
    return password_path.read_text().strip()


def build_config(
        host:str='localhost',
        user:str='root',
        password:str=get_password(),
        database:str|None=None
) -> dict:
    return dict(
        host=host,
        user=user,
        password=password,
        database=database
    )


def save_config(
        config:dict,
        config_filename:str='config.json',
        secrets_path:str=SECRETS_PATH
):
    config_path = Path(secrets_path, config_filename)
    with open(config_path, 'w') as fp:
        json.dump(config, fp, indent=4)


def load_config(
        config_filename:str='config.json',
        secrets_path:str=SECRETS_PATH
) -> dict:
    config_path = Path(secrets_path, config_filename)
    with open(config_path, 'r') as fp:
        return json.load(fp)

def get_default_config(
        config_filename:str='config.json',
        secrets_path:str=SECRETS_PATH
) -> dict:
    try:
        print(f'GET_DEFAULT_CONFIG| loading {secrets_path}/{config_filename}')
        return load_config(config_filename, secrets_path)
    except:
        print(f'GET_DEFAULT_CONFIG| loading failed, returning default')
        return build_config()
