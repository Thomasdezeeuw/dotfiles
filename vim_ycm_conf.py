def Settings(**kwargs):
    if kwargs['language'] == 'rust':
        return {
            'ls': {
                'diagnostics': {
                    'disabled': [ 'inactive-code' ],
                },
            }
        }
