import re

DICTIONARY = {
    'accepts offers': 'Accepts Offers',
    'auction': 'Auction',
    'buy it now': 'Buy It Now',
    'any condition': 'Any Condition',
    'new': 'New',
    'used': 'Used',
    'not specified': 'Not Specified',
    'best match': 'Best Match',
    'time ending soonest': 'Time: ending soonest',
    'time newly listed': 'Time: newly listed',
    'price shipping lowest first': 'Price + Shipping: lowest first',
    'price shipping highest first': 'Price + Shipping: highest first',
    'distance nearest first': 'Distance: nearest first',

}

def main():
    # text = input('Text: ')
    print(title_matters('https://www.ebay.com/b/Printing-Graphic-Arts/26238/bn_1865538'))
    # print(lookup_table(text))

def money_matters(input):
    pattern = r'\$[.\d]+'
    match = re.search(pattern, input) 
    if match != None:
        return float(match.group(0).replace('$', ''))

def lookup_table(input):
    input = input.strip().replace(':','').replace(' + ',' ').lower()
    return DICTIONARY[input]

def title_matters(input):
    if 'https' in input and '&' not in input:
        pattern = r'^https://www.ebay.com/b/([^/]+)'
        match = re.search(pattern, input)
        return match.group(1).replace('-',' ').replace('+',' ')
    elif 'https' in input and '&' in input:
        pattern = r'&_nkw=([\w+]+)'
        match = re.search(pattern, input)
        return match.group(1).replace('-',' ').replace('+',' ').lower()
    elif '&' in input:
        input = input.replace('&','').replace(',','').split()
        return ' '.join(input)
    else:
        return input

if __name__ == '__main__':
    main()