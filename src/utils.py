import re
import os
import zipfile
import gdown
import datetime 

def download_data():
  gdrive_link_file = open('gdrive_link.txt', 'r', encoding='utf-8')
  
  gdown.download(gdrive_link_file.readline().strip(), output='data.zip', fuzzy=True, quiet=False)

  os.makedirs('data', exist_ok=True)

  with zipfile.ZipFile('data.zip', 'r') as zip_ref:
    zip_ref.extractall('data')

  os.remove('data.zip')


def get_age_dict(birth_date):  
  return {'data_nascimento': birth_date,
          'idade': datetime.now().year - birth_date.year - ((datetime.now().month, datetime.now().day) < (birth_date.month, birth_date.day))
          }

# Clean extra spaces
def clean_text(text):
  return ' '.join(text.split()).strip()

# Normalize email
def normalize_email(email):
  if re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
      return email.strip()
  return 'unknown@email.com'

# Normalize cep in NNNNNNNN format
def normalize_cep(cep):
    if cep is None or cep == '':
        return None

    # Convert to string and mantain only numbers
    cep = re.sub(r'[^0-9]', '', str(cep))

    if cep:
        return cep.zfill(8)

    return None

# Split address to many fields
def get_address_dict(address):
  address_dict = {
      'endereco': None,
      'numero': None,
      'bairro': None,
      'cep': None,
      'cidade': 'N/D',
      'estado': 'NI'
  }

  if address is None or address == '':
    return address_dict

  address_match = re.search(r"(.+?), (\d+) (.+) (\d{5}-?\d{3}) (.+) / ([A-Z]{2})", address)

  if address_match:
    address_dict['endereco'] = clean_text(address_match.group(1))
    address_dict['numero'] = clean_text(address_match.group(2))
    address_dict['bairro'] = clean_text(address_match.group(3))
    address_dict['cep'] = normalize_cep(address_match.group(4))
    address_dict['cidade'] = clean_text(address_match.group(5))
    address_dict['estado'] = clean_text(address_match.group(6))

  return address_dict