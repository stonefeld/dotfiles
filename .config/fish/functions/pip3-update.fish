# Defined in - @ line 1
function pip3-update --wraps=pip3\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ pip\ install\ -U --description alias\ pip3-update\ pip3\ list\ --outdated\ --format=freeze\ \|\ grep\ -v\ \'\^\\-e\'\ \|\ cut\ -d\ =\ -f\ 1\ \ \|\ xargs\ -n1\ pip\ install\ -U
  pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U $argv;
end
