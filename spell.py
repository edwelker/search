from optparse import OptionParser
from lxml import etree
from damerau_levenshtein import dameraulevenshtein as spdiff

def main():
    usage = "Usage: %prog [options] arg"
    parser = OptionParser(usage)
    (options, args) = parser.parse_args()

    if len(args) != 1:
        parser.error("Sorry, incorrect number of arguments")

    tree = etree.parse('adjusted_menu.xml')

    results = match(tree.xpath('//title'), args[0] )
    
    print(results)

    
# need to cover
# spelling (done)
# contains
# contains with spelling
def match(xml_to_check, input):
    '''Get the distance between the input and the xml tree. Run Damerau Levenshtein on 
    lowercase names and lowercase input.'''

    adjusted_input = input.strip().lower()
    
    results = []
    for e in xml_to_check:
        distance = spdiff( e.text.strip().lower(), adjusted_input )
        if distance < 3:
            x = (etree.tostring(e.getparent()), distance)
            results.append(x)
    return results



if __name__ == '__main__':
    main()
