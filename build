


JAVA_DIR='C:/Program Files/Java/jdk-10.0.2/bin'

function _Build
{
   local ret
   
   echo "Starting $1 ..."
   mkdir ./$1/bin 2> /dev/null
   "$JAVA_DIR/javac" --add-modules java.xml.ws,java.corba -sourcepath ./$1/src -d ./$1/bin/ ./$1/src/**/*.java
   ret=$?
   echo "... Finished $1"
   return $ret
}
_Build GRAMI_UNDIRECTED_SUBGRAPHS && \
_Build GRAMI_UNDIRECTED_PATTERNS && \
_Build GRAMI_DIRECTED_SUBGRAPHS && \
_Build GRAMI_DIRECTED_PATTERNS
[[ $? == 0 ]] && echo "Done! Success"

