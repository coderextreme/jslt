<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="ds saxon"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:saxon="http://icl.com/saxon" saxon:trace="no">
    <!--        
                xmlns="http://www.w3.org/TR/xhtml1/strict"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" -->
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xsl:param name="stripComments"><xsl:text>false</xsl:text></xsl:param>
    <xsl:param name="stripDefaultAttributes"><xsl:text>true</xsl:text></xsl:param>
    <xsl:param name="indentEnabled"><xsl:text>true</xsl:text></xsl:param>
    <xsl:param name="sourceText"><xsl:text>strings</xsl:text></xsl:param> <!-- escaped | strings | plaintext -->
    <xsl:param name="traceEnabled" ><xsl:text>false</xsl:text></xsl:param>
    <xsl:param name="traceScripts" ><xsl:text>false</xsl:text></xsl:param>
    <xsl:template name="apply-templates">
	    <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="*">
	<xsl:choose>
		<xsl:when test="local-name() = 'template'">
			<xsl:value-of select="local-name()"/>["<xsl:value-of select="@name"/><xsl:value-of select="@match"/>"] = function (ignore
			<xsl:for-each select="*">
				<xsl:if test="local-name() = 'param'">
					<xsl:text>,</xsl:text>
					<xsl:value-of select="@name"/> = <xsl:call-template name="apply-templates"/>
				</xsl:if>
			</xsl:for-each>
			){
			<xsl:for-each select="*">
				<xsl:if test="local-name() != 'param'">
					<xsl:call-template name="apply-templates"/>
				</xsl:if>
			</xsl:for-each>
			}
		</xsl:when>
		<xsl:when test="local-name() = 'call-template'">
			template["<xsl:value-of select="@name"/>"](
				<xsl:apply-templates select="with-param"/>
			);
		</xsl:when>
		<xsl:when test="local-name() = 'apply-templates'">
			apply_templates(
				<xsl:call-template name="process-select">
					<xsl:with-param name="selectString" select="parent::apply-templates/@select"/>
				</xsl:call-template>
				<xsl:apply-templates select="with-param"/>
			);
		</xsl:when>
		<xsl:when test="local-name() = 'with-param'">
			<xsl:text>,</xsl:text>
			<xsl:call-template name="process-select">
				<xsl:with-param name="selectString" select="parent::with-param/@select"/>
			</xsl:call-template>
		</xsl:when>
		<!--xsl:when test="local-name() = 'param'">
			<xsl:text>, </xsl:text><xsl:value-of select="@name"/> = <xsl:call-template name="apply-templates"/>
		</xsl:when-->
		<xsl:when test="local-name() = 'if'">
			if (
				<xsl:call-template name="process-test">
					<xsl:with-param name="testString" select="parent::if/@test"/>
				</xsl:call-template>
			) {
				<xsl:call-template name="apply-templates"/>
			}
		</xsl:when>
		<xsl:when test="local-name() = 'value-of'">
				<xsl:call-template name="process-select">
					<xsl:with-param name="selectString" select="parent::value-of/@select"/>
				</xsl:call-template>
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'variable'">
			let <xsl:value-of select="translate(@name, '-', '')"/>=
				<xsl:call-template name="process-select">
					<xsl:with-param name="selectString" select="parent::variable/@select"/>
				</xsl:call-template>
			;
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'for-each'">
			for(let d in 
				<xsl:call-template name="process-select">
					<xsl:with-param name="selectString" select="parent::for-each/@select"/>
				</xsl:call-template>
			) {
				<xsl:call-template name="apply-templates"/>
			}
		</xsl:when>
		<xsl:when test="local-name() = 'choose'">
			if (false) {
			<xsl:call-template name="apply-templates"/>
			}
		</xsl:when>
		<xsl:when test="local-name() = 'when'">
			} else if (
				<xsl:call-template name="process-test">
					<xsl:with-param name="testString" select="parent::when/@test"/>
				</xsl:call-template>
			) {
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'otherwise'">
			} else {
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'stylesheet'">
			let <xsl:value-of select="local-name()"/> = function (ignore
			<xsl:for-each select="*">
				<xsl:if test="local-name() = 'param'">
					<xsl:text>,</xsl:text>
					<xsl:value-of select="@name"/> = <xsl:call-template name="apply-templates"/>
				</xsl:if>
			</xsl:for-each>
			){
				function apply_template(templates)  {
					console.log("Applying", templates);
					return templates;
				}
				function select(select) {
					console.log("Using XPath to find ", str);
					return select;
				}
				function test(predicate) {
					console.log("test is", predicate);
					return true;
				}
				function text(str) {
					console.log(str);
					return str;
				}
				function xsltextstr() {
					console.log(str);
					return str;
				}
				let template = {};
			<xsl:for-each select="*">
				<xsl:if test="local-name() != 'param'">
					<xsl:call-template name="apply-templates"/>
				</xsl:if>
			</xsl:for-each>
			}
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="comment()">
			/*
			<xsl:value-of select="comment()"/>
			*/
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'text'">
			xsltext(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="text()"/></xsl:with-param></xsl:call-template>)
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'message'">
			process.stderr.write(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="text()"/></xsl:with-param></xsl:call-template>);
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'output'">
			<xsl:message>xsl:output not implemented</xsl:message>
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
		<xsl:when test="local-name() = 'sort'">
				sort(
				<xsl:call-template name="process-select">
					<xsl:with-param name="selectString" select="parent::sort/@select"/>
				</xsl:call-template>
				);
			<xsl:call-template name="apply-templates"/>
		</xsl:when>
	</xsl:choose>
    </xsl:template>
    <xsl:template match="text()">
			text(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>)
    </xsl:template>
    <xsl:template match="comment()">
			comment(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>)
    </xsl:template>
    <xsl:template name="process-select">
	    <xsl:param name="selectString"/>
	    select(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="$selectString"/></xsl:with-param></xsl:call-template>)
    </xsl:template>
    <xsl:template name="process-test">
	    <xsl:param name="testString"/>
	    test(<xsl:call-template name="process-text"><xsl:with-param name="textString"><xsl:value-of select="$testString"/></xsl:with-param></xsl:call-template>)
    </xsl:template>
    <!-- The rest of the file is from Don Brutzman's X3dToJson.xslt -->
    <xsl:template name="process-text">
	    <xsl:param name="textString"/>
                <xsl:variable name="elementName" select="local-name(..)"/>
                <xsl:variable name="sourceStringText">
                    <xsl:call-template name="escape-quotes-recurse">
                        <xsl:with-param name="textString">
                            <xsl:call-template name="omit-leading-trailing-whitespace">
                              <xsl:with-param name="textString">
				<xsl:call-template name="escape-backslash-characters-recurse">
					<xsl:with-param name="textString"><xsl:value-of select="$textString"/></xsl:with-param>
				</xsl:call-template>
			      </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
		<xsl:choose>
	            <xsl:when test="substring($sourceStringText,1,1) = '&quot;'">
                        <xsl:value-of select="$sourceStringText"/><!-- it's already quoted -->
                    </xsl:when>
		    <!--
	            <xsl:when test="$sourceStringText = '&quot;&quot;'">
                        <xsl:value-of select="$sourceStringText"/>
                    </xsl:when>
		    -->
                    <xsl:when test="($sourceText = 'escaped')">
                        <xsl:text>"</xsl:text>
                        <xsl:call-template name="replace-newlines-recurse">
                            <xsl:with-param name="textString">
                                <xsl:call-template name="replace-tabs-recurse">
                                    <xsl:with-param name="textString" select="$sourceStringText"/>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:text>"</xsl:text>
                    </xsl:when>
                    <xsl:when test="($sourceText = 'plaintext')">
                        <xsl:text>"</xsl:text>
                        <xsl:value-of select="$sourceStringText"/> <!-- newline and tab characters unmodified -->
                        <xsl:text>"</xsl:text>
                    </xsl:when>
                    <xsl:when test="($sourceText = 'strings')">
                        <xsl:text>"</xsl:text>
                        <xsl:call-template name="split-text-block-into-string-array">
                            <xsl:with-param name="textString">
                                <xsl:call-template name="replace-tabs-recurse">
                                    <xsl:with-param name="textString" select="$sourceStringText"/>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:text>"</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                            <xsl:message>
                                <xsl:text>illegal value for $sourceText=</xsl:text>
                                <xsl:value-of select="$sourceText"/>
                                <xsl:text>, allowed values are escaped | strings | plaintext.  Using default $sourceText=strings</xsl:text>
                            </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
    </xsl:template>
    <!-- print-indent keeps track of indenting level -->
    <xsl:template name="print-indent">
      <xsl:param name="indent"><xsl:text>0</xsl:text></xsl:param>
      <xsl:if test="($indentEnabled = 'true') and ($indent > 0)">
        <xsl:text> </xsl:text>
        <xsl:call-template name="print-indent">
          <xsl:with-param name="indent" select="$indent - 1"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:template>
    
    <xsl:template name="escape-special-characters-quotes-recurse">
        <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
        <xsl:param name="inputType"><xsl:text>false</xsl:text></xsl:param>
        
        <xsl:call-template name="escape-quotes-recurse">
            <xsl:with-param name="inputType"><xsl:value-of select="$inputType"/></xsl:with-param>
            <xsl:with-param name="textString">
                <xsl:call-template name="escape-less-than-characters-recurse">
                    <xsl:with-param name="textString">
                        <xsl:call-template name="escape-greater-than-characters-recurse">
							<xsl:with-param name="textString">
								<xsl:call-template name="escape-backslash-characters-recurse">
									<xsl:with-param name="textString" select="normalize-space($textString)"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="escape-quotes-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:param name="inputType"><xsl:text>false</xsl:text></xsl:param>
      <!-- debug (also use trace messages below) -->
      <xsl:variable name="debugTrace" select="false()"/><!-- true() false() -->
      <xsl:variable name="debugMessage">
          <xsl:text>[local-name()=</xsl:text>
          <xsl:value-of select="local-name()"/>
		  <xsl:if test="self::comment()">
			<xsl:text>comment</xsl:text>
		  </xsl:if>
          <xsl:text>]</xsl:text>
          <xsl:variable name="reentry" select="$textString"/>
          <xsl:value-of select="$reentry" disable-output-escaping="yes"/>
          <xsl:text>[inputType=</xsl:text>
          <xsl:value-of select="$inputType"/>
          <xsl:text>]</xsl:text>
      </xsl:variable>
      
      <!--  escaped quote " within an SFString value requires a preceding backslash \ in JSON encoding. -->
      <!--  must be careful not to escape "delimiting" "quotes" in MFString array. -->
      <xsl:choose>
        <!-- no quote, all done -->
        <xsl:when test="not(contains($textString,'&quot;')) and not(contains($textString,'\'))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[1]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <!-- comment: XML-escaped \&amp;quot; (before regular \&quot;) needs to be handled -->
        <xsl:when test="self::comment() and contains($textString,'\&amp;quot;') and 
                       (string-length(substring-before($textString,'&quot;')) > string-length(substring-before($textString,'\&amp;quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[1.5]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'\\&amp;quot;')"/>
          <xsl:text disable-output-escaping="yes">\\\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'\&amp;quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- comment: XML-escaped &amp;quot; (before regular &quot;) needs to be handled -->
        <xsl:when test="self::comment() and contains($textString,'&amp;quot;') and 
                       (string-length(substring-before($textString,'&quot;')) > string-length(substring-before($textString,'&amp;quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[1.6]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'&amp;quot;')"/>
          <xsl:text>"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'&amp;quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- comment: escaped quote needs to be left alone -->
        <xsl:when test="self::comment() and contains($textString,'\&quot;') and 
                       (string-length(substring-before($textString,'&quot;')) -1 > string-length(substring-before($textString,'\&quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[2]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'\&quot;')"/>
          <xsl:text disable-output-escaping="yes">\\\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'\&quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- comment: backslash (no following quotes ") needs to be escaped -->
        <xsl:when test="self::comment() and contains($textString,'\') and 
                       (not(contains($textString,'&quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[2.3 \ to \\]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'\')"/>
          <xsl:text disable-output-escaping="yes">\\</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'\')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- comment: backslash (preceding ") needs to be escaped -->
        <xsl:when test="self::comment() and contains($textString,'\') and 
                       (string-length(substring-before($textString,'&quot;')) > string-length(substring-before($textString,'\')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[2.4 \ to \\]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'\')"/>
          <xsl:text disable-output-escaping="yes">\\</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'\')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- comment: unescaped quote needs \ escape character inserted, no quote delimiter remaining -->
        <xsl:when test="self::comment() and contains($textString,'&quot;')">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[2.5 " to \"]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'&quot;')"/>
          <xsl:text disable-output-escaping="yes">\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'&quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- SFString with quoted value -->
        <xsl:when test="($inputType = 'SFString') and starts-with($textString,'&quot;')">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[3]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:text disable-output-escaping="yes">\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring($textString,2,string-length($textString) - 1)"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- SFString or MFString containing empty string "" -->
        <xsl:when test="starts-with($textString,'&quot;&quot;')">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[3.5]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:text>""</xsl:text>
		  <xsl:if test="(string-length(normalize-space(substring($textString,3))) > 0)">
			<xsl:text>,</xsl:text>
			<xsl:call-template name="escape-quotes-recurse">
				<xsl:with-param name="textString" select="substring($textString,3)"/>
				<xsl:with-param name="inputType"   select="$inputType"/>
			</xsl:call-template>
		  </xsl:if>
		  <xsl:if test="($inputType = 'SFString')">
			  <xsl:message>
				  <xsl:text>Error: malformed SFString value has "" empty string followed by extra characters: </xsl:text>
			      <xsl:value-of select="substring($textString,3)"/>
			  <xsl:value-of select="$debugMessage"/></xsl:message>
		  </xsl:if>
        </xsl:when>
        <!-- starting and ending quotes indicate outer delimeters of MFString array -->
        <xsl:when test="starts-with($textString,'&quot;') and ends-with($textString,'&quot;') and not(ends-with($textString,'\&quot;'))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[4]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:text>"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring($textString,2,string-length($textString) - 2)"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
          <xsl:text>"</xsl:text>
        </xsl:when>
        <!-- strings: skip past escaped quote character \" (a literal value, not a delimiter) then recurse to process remainder -->
        <xsl:when test="contains($textString,'\&quot;') and (string-length(substring-before($textString,'&quot;')) > string-length(substring-before($textString,'\&quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[5]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'\&quot;')"/>
          <xsl:text disable-output-escaping="yes">\\\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'\&quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- MFString value next contains quotes delimiter between SFString array elements, but check no preceding unescaped quote -->
        <xsl:when test="($inputType = 'MFString') and contains($textString,'&quot; &quot;') and (string-length(substring-before($textString,'&quot;')) >= string-length(substring-before($textString,'&quot; &quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[6]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'&quot; &quot;')"/>
          <xsl:text>" "</xsl:text>          
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'&quot; &quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- unescaped quote needs \ escape character inserted, occurs before quotes delimiter -->
        <xsl:when test="($inputType = 'MFString') and contains($textString,'&quot; &quot;') and (string-length(substring-before($textString,'&quot; &quot;')) > string-length(substring-before($textString,'&quot;')))">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[7]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'&quot;')"/>
          <xsl:text disable-output-escaping="yes">\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'&quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- unescaped quote needs \ escape character inserted, no quote delimiter remaining -->
        <xsl:when test="contains($textString,'&quot;')">
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[8]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="substring-before($textString,'&quot;')"/>
          <xsl:text disable-output-escaping="yes">\"</xsl:text>
          <xsl:call-template name="escape-quotes-recurse">
              <xsl:with-param name="textString" select="substring-after($textString,'&quot;')"/>
              <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- remaining case: all done -->
        <xsl:otherwise>
          <xsl:if test="$debugTrace"><xsl:message><xsl:text>[9]</xsl:text><xsl:value-of select="$debugMessage"/></xsl:message></xsl:if>
          <xsl:value-of select="$textString"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="omit-leading-trailing-whitespace">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- not normalized white space  -->
      <!-- debug <xsl:message><xsl:text>omit-leading-trailing-whitespace</xsl:text></xsl:message> -->
      <xsl:choose>
        <!-- space &nbsp; \t \n \r respectively -->
        <xsl:when test="starts-with($textString,' ')     or starts-with($textString,'&#160;') or
                        starts-with($textString,'&#09;') or starts-with($textString,'&#x0A;') or
                        starts-with($textString,'&#x0D;')">
          <xsl:call-template name="omit-leading-trailing-whitespace">
              <xsl:with-param name="textString" select="substring($textString,2)"/>
          </xsl:call-template>
        </xsl:when>
        <!-- space &nbsp; \t \n \r respectively -->
        <xsl:when test="  ends-with($textString,' ')     or   ends-with($textString,'&#160;') or
                          ends-with($textString,'&#09;') or   ends-with($textString,'&#x0A;') or
                          ends-with($textString,'&#x0D;')">
          <xsl:call-template name="omit-leading-trailing-whitespace">
              <xsl:with-param name="textString" select="substring($textString,1,(string-length($textString)-1))"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <!-- done -->
          <xsl:value-of select="$textString"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="escape-backslash-characters-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:choose>
        <xsl:when test="not(contains($textString,'\'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'\')"/>
		  <xsl:variable name="nextChar"  select="substring(substring-after($textString,'\'),1,1)"/>
		  <xsl:variable name="remainder" select="substring(substring-after($textString,'\'),2)"/>
		  <!-- pass through escaped characters   http://www.web3d.org/x3d/stylesheets/X3dToJson.html#strings -->
		  <xsl:choose>
			  <!-- double backslash is already escaped, pass it through -->
			  <xsl:when test="($nextChar = '\') and ($remainder[1] = '\')">
				<xsl:text disable-output-escaping="yes">\\</xsl:text>
				<xsl:call-template name="escape-backslash-characters-recurse">
				  <xsl:with-param name="textString" select="substring($remainder,2)"/>
				</xsl:call-template>
			  </xsl:when>
			  <!-- special characters backspace, formfeed, newline, carriage return, horizontal tab are presumably character entities already -->
			  <!-- page links for character entities http://www.web3d.org/x3d/content/examples/X3dSceneAuthoringHints.html#HTML -->
			  <!-- http://www.w3schools.com/js/js_strings.asp -->
			  <xsl:when test="($nextChar = '&quot;') or ($nextChar = '\') or ($nextChar = '/') or
                              ($nextChar = 'n') or ($nextChar = 'r') or ($nextChar = 't') or ($nextChar = 'b') or ($nextChar = 'f')">
				  <xsl:text disable-output-escaping="yes">\</xsl:text>
				  <xsl:value-of select="$nextChar"/>
				<xsl:call-template name="escape-backslash-characters-recurse">
				  <xsl:with-param name="textString" select="$remainder"/>
				</xsl:call-template>
			  </xsl:when>
			  <xsl:when test='($nextChar = "&apos;")'>
				  <xsl:text disable-output-escaping="yes">\</xsl:text>
				  <xsl:value-of select="$nextChar"/>
				<xsl:call-template name="escape-backslash-characters-recurse">
				  <xsl:with-param name="textString" select="$remainder"/>
				</xsl:call-template>
			  </xsl:when>
			  <xsl:when test="(normalize-space($nextChar) = ' ') or (normalize-space($nextChar) = '')">
                         <!-- or ($nextChar = '&amp;') start of character entity -->
				  <xsl:text disable-output-escaping="yes">\\</xsl:text>
				  <xsl:value-of select="$nextChar"/>
				<xsl:call-template name="escape-backslash-characters-recurse">
				  <xsl:with-param name="textString" select="$remainder"/>
				</xsl:call-template>
			  </xsl:when>
			  <!-- TODO are more thorough checks needed? https://tools.ietf.org/html/rfc7159#section-7 -->
			  <!-- TODO any special handling needed for ($nextChar = '\&apos;') ? -->
			  <xsl:otherwise> <!-- allow this backslash character to escape whatever follows -->
				  <xsl:text disable-output-escaping="yes">\</xsl:text>
				  <xsl:value-of select="$nextChar"/>
				<xsl:call-template name="escape-backslash-characters-recurse">
				  <xsl:with-param name="textString" select="$remainder"/>
				</xsl:call-template>
			  </xsl:otherwise>
		  </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="escape-less-than-characters-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:choose>
        <xsl:when test="not(contains($textString,'&lt;'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'&lt;')"/>
          <xsl:text>&lt;</xsl:text>
          <xsl:call-template name="escape-less-than-characters-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'&lt;')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
	
    <xsl:template name="replace-newlines-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- not normalized white space -->
      <xsl:choose>
        <xsl:when test="not(contains($textString,'&#x0A;'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'&#x0A;')"/>
          <xsl:text>\n</xsl:text>
          <xsl:call-template name="replace-newlines-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'&#x0A;')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="replace-tabs-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- not normalized white space -->
      <xsl:choose>
        <xsl:when test="not(contains($textString,'&#x09;'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'&#x09;')"/>
          <xsl:text>\t</xsl:text>
          <xsl:call-template name="replace-tabs-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'&#x09;')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="escape-greater-than-characters-recurse">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:choose>
        <xsl:when test="not(contains($textString,'&gt;'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'&gt;')"/>
          <xsl:text>&gt;</xsl:text>
          <xsl:call-template name="escape-greater-than-characters-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'&gt;')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="insert-commas-recurse">
      <!-- insert commas before space characters between array values -->
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:param name="inputType"><xsl:text></xsl:text></xsl:param><!-- data type for this field -->
      <xsl:choose>
        <!-- no space, all done -->
        <xsl:when test="not(contains($textString,' '))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <!-- strings: skip past escaped quote character \" (a literal value, not a delimiter) then recurse to process first unescaped quote character " -->
        <xsl:when test="contains($textString,'\\&quot;') and (string-length(substring-before($textString,'&quot;')) > string-length(substring-before($textString,'\\&quot;')))">
          <xsl:value-of select="substring-before($textString,'\&quot;')"/>
          <xsl:text disable-output-escaping="yes">\\\&quot;</xsl:text>
          <xsl:call-template name="insert-commas-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'\&quot;')"/>
            <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- insert commas after next contained SFString within an MFString array -->
        <xsl:when test="contains($textString,'&quot; &quot;')">
          <xsl:value-of select="substring-before($textString,'&quot; &quot;')"/>
          <xsl:text>&quot;,&quot;</xsl:text>
          <xsl:call-template name="insert-commas-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'&quot; &quot;')"/>
            <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
        </xsl:when>
        <!-- do not insert commas within string types -->
        <xsl:when test="($inputType = 'SFString') or ($inputType = 'MFString')">
          <!-- MFString commas between SFString values already handled, so do not insert further commas -->
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:when test="(local-name()='url') or contains(local-name(),'Url')">
          <!-- do not modify space characters within a url value, all done -->
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <!-- other values: has spaces, type is non SFString/MFString array; replace space characters with commas directly -->
        <xsl:otherwise>
            <xsl:value-of select="translate($textString,' ',',')"/>
          <!--
          <xsl:value-of select="substring-before($textString,' ')"/>
          <xsl:text>,</xsl:text>
          <xsl:call-template name="insert-commas-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,' ')"/>
            <xsl:with-param name="inputType"   select="$inputType"/>
          </xsl:call-template>
          -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="split-text-block-into-string-array">
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- not normalized white space -->
      <xsl:choose>
        <!-- no line feed, all done -->
        <xsl:when test="not(contains($textString,'&#x0A;'))">
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($textString,'&#x0A;')"/>
          <xsl:text>\n</xsl:text>
          <xsl:call-template name="split-text-block-into-string-array">
            <xsl:with-param name="textString" select="substring-after($textString,'\n')"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <xsl:template name="output-integers">
        <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
        <xsl:for-each select="tokenize($textString, '\s')">
            <xsl:variable name="singleInteger" select="."/>
            <xsl:choose>
                <!-- Convert hexadecimal values to decimal -->
                <xsl:when test="starts-with($singleInteger, '0x')">
                    <xsl:call-template name="hexToDecimal">
                        <xsl:with-param name="hexDigits" select="substring($singleInteger, 3)"/>
                    </xsl:call-template>
                </xsl:when>
                <!-- Already decimal so just print out -->
                <xsl:otherwise>
                    <xsl:value-of select="$singleInteger"/>
                </xsl:otherwise>
            </xsl:choose>
            <!--  array values require comma between values in JSON encoding -->
            <xsl:if test="last() > position()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="hexToDecimal">
        <!-- Converts hexadecimal digits to decimal value, one digit at a time using recursion-->
        <xsl:param name="hexDigits"/> <!-- The hexadecimal digits to be converted -->
        <xsl:param name="decimalValue" select="0"/> <!-- The decimal value, which may already be partly computed -->
        <xsl:variable name="mostSignificantHexDigit" select="translate(substring($hexDigits, 1, 1), 'abcdef', 'ABCDEF')"/>
        <!-- One line trick to convert 0 to 0, 1 to 1, ..., A to 10, B to 11, ..., F to 16 -->
        <xsl:variable name="decimalValueOfHexDigit" select="string-length(substring-before('0123456789ABCDEF', $mostSignificantHexDigit))"/>
        <xsl:variable name="result" select="16 * $decimalValue + $decimalValueOfHexDigit"/>
        <xsl:choose>
            <!-- tail recursion to convert leading value in array from hexadecimal to integer -->
            <xsl:when test="string-length($hexDigits) > 1">
                <xsl:call-template name="hexToDecimal">
                    <xsl:with-param name="hexDigits" select="substring($hexDigits, 2)"/>
                    <xsl:with-param name="decimalValue" select="$result"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="output-reals">
        <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
        <!-- insert leading zeroes before float values starting with decimal point; omit leading + signs -->
        <xsl:for-each select="tokenize($textString, '\s')">
            <xsl:variable name="singleReal" select="."/>
            <xsl:call-template name="insert-leading-trailing-zero">
                <xsl:with-param name="inputReal" select="$singleReal"/>
            </xsl:call-template>
            <!--  array values require comma between values in JSON encoding -->
            <xsl:if test="last() > position()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="insert-leading-trailing-zero">
        <xsl:param name="inputReal"><xsl:text></xsl:text></xsl:param>
        <xsl:choose>
            <!-- starts with decimal point, insert 0 -->
            <xsl:when test="starts-with($inputReal,'.')">
                <xsl:text>0</xsl:text>
                <xsl:value-of select="$inputReal"/>
            </xsl:when>
            <!-- starts with plus sign, delete and re-check -->
            <xsl:when test="starts-with($inputReal,'+')">
                <xsl:call-template name="insert-leading-trailing-zero">
                    <xsl:with-param name="inputReal" select="substring-after($inputReal,'+')"/>
                </xsl:call-template>
            </xsl:when>
            <!-- starts with minus sign and decimal point, insert 0 -->
            <xsl:when test="starts-with($inputReal,'-.')">
                <xsl:text>-0</xsl:text>
                <xsl:value-of select="substring($inputReal,2)"/>
            </xsl:when>
			<!-- missing numeral after decimal point before scientific notation, insert 0 -->
			<xsl:when test="contains($inputReal,'.e')">
				<xsl:value-of select="substring-before($inputReal,'.e')"/>
				<xsl:text>.0e</xsl:text>
				<xsl:value-of select="substring-after($inputReal,'.e')"/>
			</xsl:when>
			<xsl:when test="contains($inputReal,'.E')">
				<xsl:value-of select="substring-before($inputReal,'.E')"/>
				<xsl:text>.0E</xsl:text>
				<xsl:value-of select="substring-after($inputReal,'.E')"/>
			</xsl:when>
            <!-- doesn't start with decimal point -->
            <xsl:otherwise>
              <xsl:value-of select="$inputReal"/>
              <xsl:if test="ends-with($inputReal,'.')">
                  <!-- append 0 after trailing decimal point -->
                  <xsl:text>0</xsl:text>
              </xsl:if>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>
    <xsl:template name="insert-leading-trailing-zeroes-recurse">
        <!-- insert leading zeroes before float values starting with decimal point; omit leading + signs -->
      <xsl:param name="textString"><xsl:text></xsl:text></xsl:param> <!-- already normalized white space -->
      <xsl:choose>
        <!-- starts with decimal point, insert 0, more to follow -->
        <xsl:when test="starts-with($textString,'.') and contains($textString,' ')">
          <xsl:text>0</xsl:text>
          <xsl:value-of select="substring-before($textString,' ')"/>
          <xsl:text> </xsl:text>
          <xsl:call-template name="insert-leading-trailing-zeroes-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,' ')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- starts with decimal point, insert 0, all done -->
        <xsl:when test="starts-with($textString,'.')">
          <xsl:text>0</xsl:text>
          <xsl:value-of select="$textString"/>
        </xsl:when>
        <!-- starts with decimal point, insert 0, more to follow -->
        <xsl:when test="starts-with($textString,'+')">
          <xsl:call-template name="insert-leading-trailing-zeroes-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,'+')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- starts with minus sign and decimal point, insert 0, more to follow -->
        <xsl:when test="starts-with($textString,'-.') and contains($textString,' ')">
          <xsl:text>-0</xsl:text>
          <xsl:value-of select="substring-before(substring($textString,2),' ')"/>
          <xsl:text> </xsl:text>
          <xsl:call-template name="insert-leading-trailing-zeroes-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,' ')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- starts with minus sign and decimal point, insert 0, all done -->
        <xsl:when test="starts-with($textString,'-.')">
          <xsl:text>-0</xsl:text>
          <xsl:value-of select="substring($textString,2)"/>
        </xsl:when>
        <!-- doesn't start with decimal point, more to follow -->
        <xsl:when test="contains($textString,' ')">
          <xsl:value-of select="substring-before($textString,' ')"/>
          <xsl:if test="ends-with(substring-before($textString,' '),'.')">
              <!-- append 0 after trailing decimal point -->
              <xsl:text>0</xsl:text>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:call-template name="insert-leading-trailing-zeroes-recurse">
            <xsl:with-param name="textString" select="substring-after($textString,' ')"/>
          </xsl:call-template>
        </xsl:when>
        <!-- doesn't start with decimal point, all done -->
        <xsl:otherwise>
          <xsl:value-of select="$textString"/>
          <xsl:if test="ends-with($textString,'.')">
              <!-- append 0 after trailing decimal point -->
              <xsl:text>0</xsl:text>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    <!-- trace messsages on console -->
    <xsl:template name="trace">
      <xsl:param name="message"><xsl:text></xsl:text></xsl:param>
      <xsl:param name="element"><xsl:text></xsl:text></xsl:param>
      <xsl:param name="name"><xsl:text></xsl:text></xsl:param>
      <xsl:param name="DEF"><xsl:text></xsl:text></xsl:param>
      <xsl:param name="USE"><xsl:text></xsl:text></xsl:param>
      <xsl:param name="indent"><xsl:text>0</xsl:text></xsl:param>
      <xsl:param name="traceEnabled" select="$traceEnabled"/>
      
      <xsl:if test="($traceEnabled = 'true')">
        <xsl:variable name="fullMessage">
            <xsl:call-template name="print-indent">
                <xsl:with-param name="indent" select="$indent - 1"/>
            </xsl:call-template>
            <xsl:if test="(string-length(normalize-space($element)) > 0)">
                <xsl:value-of select="normalize-space($element)"/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="(string-length($name) > 0)">
                <xsl:text>name=</xsl:text>
                <xsl:value-of select="$name"/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="(string-length($DEF) > 0)">
                <xsl:text>DEF=</xsl:text>
                <xsl:value-of select="$DEF"/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="(string-length($USE) > 0)">
                <xsl:text>USE=</xsl:text>
                <xsl:value-of select="$USE"/>
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space($message)"/>
        </xsl:variable>
        <xsl:if test="(string-length(normalize-space($fullMessage)) > 0)">
            <xsl:message>
				<xsl:value-of select="normalize-space($fullMessage)"/>
			</xsl:message>
        </xsl:if>
      </xsl:if>
    </xsl:template>
    <xsl:template name="not-default-attribute-value"> <!-- rule to filter out default attribute values -->
                
        <!-- this block of tests is used identically in X3dToXhtml.xslt X3dToHtml.xslt X3dToVrml97.xslt X3dTidy.xslt X3dToX3dom.xslt X3dUnwrap.xslt X3dWrap.xslt and X3dToJson.xslt -->
        <!-- check values with/without .0 suffix since these are string checks and autogenerated/DOM output might have either -->
        <!-- do not check ProtoInstance fields or natively defined nodes, since they might have different user-defined defaults -->
        <!-- tool-bug workaround:  split big boolean queries into pieces to avoid overloading the Xalan/lotusxml query buffer -->
        <xsl:variable name="notImplicitEvent1"
                      select="not(local-name(..)='AudioClip'	and	(local-name()='duration_changed' or local-name()='elapsedTime' or local-name()='isPaused' or local-name()='isActive')) and
                      not(contains(local-name(..),'Interpolator') and (local-name()='set_fraction' or local-name()='value_changed')) and
                      not(contains(local-name(..),'Sequencer')    and (local-name()='set_fraction' or local-name()='value_changed' or local-name()='previous' or local-name()='next')) and
                      not(local-name(..)='Background'	and	(local-name()='set_bind' or local-name()='bindTime' or local-name()='isBound')) and
                      not(local-name(..)='Collision' and (local-name()='isActive' or local-name()='collideTime')) and
                      not(local-name(..)='CylinderSensor' and	(local-name()='isActive' or local-name()='isOver' or local-name()='rotation' or local-name()='trackPoint_changed')) and
                      not(local-name(..)='ElevationGrid'	and	local-name()='set_height') and
                      not((local-name(..)='Extrusion') and starts-with(local-name(),'set_')) and
                      not(((local-name(..)='IndexedFaceSet') or contains(local-name(..),'TriangleFanSet') or contains(local-name(..),'TriangleSet') or contains(local-name(..),'TriangleStripSet') or contains(local-name(..),'QuadSet')) and starts-with(local-name(),'set_') and contains(local-name(),'ndex')) and
                      not(local-name(..)='IndexedLineSet' and	 local-name()='lineWidth') and
                      not(local-name(..)='MovieTexture' and	(local-name()='duration_changed' or local-name()='elapsedTime' or local-name()='isPaused' or local-name()='isActive')) and
                      not(local-name(..)='NavigationInfo' and	(local-name()='set_bind' or local-name()='bindTime' or local-name()='isBound'))
                      " />
        <xsl:variable name="notImplicitEvent2"
                      select="not(local-name(..)='PointSet'	and	 local-name()='pointSize') and
                      not(local-name(..)='PlaneSensor' and	(local-name()='isActive' or local-name()='isOver' or local-name()='translation_changed' or local-name()='trackPoint_changed')) and
                      not(local-name(..)='ProximitySensor' and (local-name()='isActive' or local-name()='position' or local-name()='orientation' or
                      local-name()='enterTime' or local-name()='exitTime')) and
                      not(local-name(..)='SphereSensor' and	(local-name()='isActive' or local-name()='rotation' or local-name()='trackPoint_changed')) and
                      not(local-name(..)='TimeSensor'	and	(local-name()='isActive' or local-name()='elapsedTime' or local-name()='isPaused' or local-name()='cycleTime' or local-name()='set_fraction' or
                      local-name()='time')) and
                      not(local-name(..)='TouchSensor' and	(local-name()='isActive' or local-name()='isOver' or local-name()='hitNormal_changed' or
                      local-name()='touchTime' or local-name()='hitPoint_changed' or local-name()='hitTexCoord_changed')) and
                      not(local-name(..)='Viewpoint'	  and	(local-name()='set_bind' or local-name()='bindTime' or local-name()='isBound' or local-name()='examine')) and
                      not(local-name(..)='GeoViewpoint' and	(local-name()='set_bind' or local-name()='bindTime' or local-name()='isBound' or local-name()='examine'))
                      " />
        <xsl:variable name="notImplicitEvent3"
                      select="not(local-name(..)='BooleanTrigger'	and	(local-name()='set_triggerTime' or local-name()='triggerTrue')) and
                      not(local-name(..)='IntegerTrigger'	and	(local-name()='set_boolean' or local-name()='triggerValue'))
                      " />
        <xsl:variable name="notDefaultFieldValue1"
                      select="not( local-name()='bboxCenter'	and	(.='0 0 0' or .='0.0 0.0 0.0')) and
                      not( local-name()='bboxSize'	and	(.='-1 -1 -1' or .='-1.0 -1.0 -1.0')) and
                      not( local-name(..)='AudioClip'	and
                      ((local-name()='loop' and .='false') or
                      (local-name()='pitch' and (.='1' or .='1.0')) or
                      (local-name()='startTime' and (.='0' or .='0.0')) or
                      (local-name()='stopTime' and (.='0' or .='0.0')) or
                      (local-name()='pauseTime' and (.='0' or .='0.0')) or
                      (local-name()='resumeTime'  and (.='0' or .='0.0')))) and
                      not(((local-name(..)='Background') or (local-name(..)='TextureBackground')) and ((local-name()='skyColor' and (.='0 0 0' or .='0.0 0.0 0.0')) or (local-name()='transparency' and (.='0' or .='0.0')))) and
                      not( local-name(..)='Billboard'	and local-name()='axisOfRotation' and (.='0 1 0' or .='0.0 1.0 0.0')) and
                      not( local-name(..)='BooleanToggle' and local-name()='toggle' and .='false') and
                      not( local-name(..)='Box'	and ((local-name()='size' and (.='2 2 2' or .='2.0 2.0 2.0')) or (local-name()='solid' and .='true'))) and
                      not( local-name(..)='Collision'	and local-name()='enabled' and .='true') and
                      not( local-name(..)='Cone' and	((local-name()='bottomRadius' and (.='1' or .='1.0')) or
                      (local-name()='height' and (.='2' or .='2.0')) or
                      (local-name()='side' and .='true') or
                      (local-name()='solid' and .='true') or
        (local-name()='bottom' and .='true')))"/>
        <xsl:variable name="notDefaultFieldValue1a"
                      select="not( local-name(..)='Cylinder' and
                      ((local-name()='height' and (.='2' or .='2.0')) or
                      (local-name()='radius' and (.='1' or .='1.0')) or
                      (local-name()='bottom' and .='true') or
                      (local-name()='side' and .='true') or
                      (local-name()='solid' and .='true') or
                      (local-name()='top' and .='true'))) and
                      not( local-name(..)='CylinderSensor' and
                      ((local-name()='autoOffset' and .='true') or
                      (local-name()='axisRotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='enabled' and .='true') or
                      (local-name()='diskAngle' and .='0.26179167') or
                      (local-name()='offset' and (.='0' or .='0.0')) or
                      (local-name()='maxAngle' and (.='-1' or .='-1.0')) or
                      (local-name()='minAngle' and (.='0' or .='0.0'))))" />
        <xsl:variable name="notDefaultFieldValue2"
                      select="not( local-name(..)='DirectionalLight' and
                      ((local-name()='ambientIntensity' and (.='0' or .='0.0')) or
                      (local-name()='color' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='direction' and (.='0 0 -1' or .='0.0 0.0 -1.0')) or
                      (local-name()='global' and .='false') or
                      (local-name()='intensity' and (.='1' or .='1.0')) or
                      (local-name()='on' and .='true'))) and
                      not((local-name(..)='ElevationGrid' or local-name(..)='GeoElevationGrid') and
                      ((local-name()='ccw' and .='true') or
                      (local-name()='colorPerVertex' and .='true') or
                      (local-name()='normalPerVertex' and .='true') or
                      (local-name()='solid' and .='true') or
                      (local-name()='xDimension' and (.='2')) or
                      (local-name()='xSpacing' and (.='1' or .='1.0')) or
                      (local-name()='zDimension' and (.='2')) or
                      (local-name()='zSpacing' and (.='1' or .='1.0')) or
                      (local-name()='yScale' and (.='1' or .='1.0')) or
                      (local-name()='height' and (.='0 0 0 0' or .='0.0 0.0 0.0 0.0')) or
                      (local-name()='geoGridOrigin' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='creaseAngle' and (.='0' or .='0.0')))) and
                      not( local-name(..)='Extrusion'	and
                      ((local-name()='beginCap' and .='true') or
                      (local-name()='ccw' and .='true') or
                      (local-name()='convex' and .='true') or
                      (local-name()='endCap' and .='true') or
                      (local-name()='solid' and .='true') or
                      (local-name()='creaseAngle' and (.='0' or .='0.0')) or
                      (local-name()='orientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='scale' and (.='1 1' or .='1.0 1.0')) or
                      (local-name()='crossSection' and .='1 1, 1 -1, -1 -1, -1 1, 1 1') or
                      (local-name()='crossSection' and .='1 1 1 -1 -1 -1 -1 1 1 1') or
                      (local-name()='spine' and .='0 0 0, 0 1 0') or
                      (local-name()='spine' and .='0 0 0 0 1 0')))" />
        <xsl:variable name="notDefaultFieldValue3"
                      select="not(contains(local-name(..),'Fog') and 	((local-name()='color' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='visibilityRange' and (.='0' or .='0.0')) or
                      (local-name()='enabled' and .='true') or
                      (local-name()='fogType' and .='LINEAR'))) and
                      not(contains(local-name(..),'FontStyle')	and
                      ((local-name()='horizontal' and .='true') or
                      (local-name()='leftToRight' and .='true') or
                      (local-name()='topToBottom' and .='true') or
                      (local-name()='size' and (.='1' or .='1.0')) or
                      (local-name()='spacing' and (.='1' or .='1.0')) or
                      (local-name()='pointSize' and (.='12' or .='12.0')) or
                      (local-name()='family' and .='&quot;SERIF&quot;') or
                      (local-name()='justify' and .='&quot;BEGIN&quot;') or
                      (local-name()='style' and .='PLAIN'))) and
                      not( local-name(..)='ImageTexture' and
                      ((local-name()='repeatS' and .='true') or
                      (local-name()='repeatT' and .='true'))) and
                      not(((local-name(..)='IndexedFaceSet') or contains(local-name(..),'TriangleFanSet') or contains(local-name(..),'TriangleSet') or contains(local-name(..),'TriangleStripSet') or contains(local-name(..),'QuadSet')) and
                      ((local-name()='ccw' and .='true') or
                      (local-name()='colorPerVertex' and .='true') or
                      (local-name()='convex' and .='true') or
                      (local-name()='normalPerVertex' and .='true') or
                      (local-name()='solid' and .='true') or
                      (local-name()='creaseAngle' and (.='0' or .='0.0')))) and
                      not( local-name(..)='IndexedLineSet' and local-name()='colorPerVertex' and .='true') and
                      not( local-name(..)='Inline' and local-name()='load' and .='true') and
                      not( local-name(..)='LoadSensor' and
                      ((local-name()='enabled' and .='true') or
                      (local-name()='timeOut' and (.='0' or .='0.0')))) and
                      not( local-name(..)='LOD'	and	((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or (local-name()='forceTransitions' and .='false'))) and
                      not(((local-name(..)='Material') or (local-name(..)='TwoSidedMaterial'))	and
                      ((local-name()='ambientIntensity' and .='0.2') or
                      (local-name()='diffuseColor' and .='0.8 0.8 0.8') or
                      (local-name()='emissiveColor' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='shininess' and .='0.2') or
                      (local-name()='specularColor' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='transparency' and (.='0' or .='0.0')))) and
                      not( local-name(..)='TwoSidedMaterial'	and
                      ((local-name()='backAmbientIntensity' and .='0.2') or
                      (local-name()='backDiffuseColor' and .='0.8 0.8 0.8') or
                      (local-name()='backEmissiveColor' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='backShininess' and .='0.2') or
                      (local-name()='separateBackColor' and .='false') or
                      (local-name()='backSpecularColor' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='backTransparency' and (.='0' or .='0.0'))))" />
        <xsl:variable name="notDefaultFieldValue4"
                      select="not( local-name(..)='MovieTexture' and
                      ((local-name()='loop' and .='false') or
                      (local-name()='speed' and (.='1' or .='1.0')) or
                      (local-name()='startTime' and (.='0' or .='0.0')) or
                      (local-name()='stopTime' and (.='0' or .='0.0')) or
                      (local-name()='pauseTime' and (.='0' or .='0.0')) or
                      (local-name()='resumeTime'  and (.='0' or .='0.0')) or
                      (local-name()='repeatS' and .='true') or
                      (local-name()='repeatT' and .='true'))) and
                      not( local-name(..)='NavigationInfo' and
                      ((local-name()='avatarSize' and .='0.25 1.6 0.75') or
                      (local-name()='headlight' and .='true') or
                      (local-name()='speed' and (.='1' or .='1.0')) or
                      (local-name()='transitionTime' and (.='1' or .='1.0')) or
                      (local-name()='transitionType' and (.='&quot;LINEAR&quot;')) or
					  (local-name()='type' and (.='&quot;EXAMINE&quot; &quot;ANY&quot;')) or
                      (local-name()='visibilityLimit' and (.='0' or .='0.0')))) and
                      not( local-name(..)='PixelTexture' and
                      ((local-name()='repeatS' and .='true') or
                      (local-name()='repeatT' and .='true') or
                      (local-name()='image' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='PlaneSensor' and
                      ((local-name()='autoOffset' and .='true') or
					  (local-name()='axisRotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='enabled' and .='true') or
                      (local-name()='maxPosition' and (.='-1 -1' or .='-1.0 -1.0')) or
                      (local-name()='minPosition' and (.='0 0' or .='0.0 0.0')) or
                      (local-name()='offset' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='PointLight' and
                      ((local-name()='ambientIntensity' and (.='0' or .='0.0'))or
                      (local-name()='attenuation' and (.='1 0 0' or .='1.0 0.0 0.0')) or
                      (local-name()='color' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='global' and .='true') or
                      (local-name()='intensity' and (.='1' or .='1.0')) or
                      (local-name()='location' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='on' and .='true') or
                      (local-name()='radius' and (.='100' or .='100.0'))))" />
        <xsl:variable name="notDefaultFieldValue5"
                      select="not(ends-with(local-name(..),'ProximitySensor') and
                      ((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='size' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='enabled' and .='true'))) and
                      not( local-name(..)='Script' and ((local-name()='directOutput' and .='false') or
                      (local-name()='mustEvaluate' and .='false'))) and
                      not( local-name(..)='Sound' and ((local-name()='direction' and (.='0 0 1' or .='0.0 0.0 1.0')) or
                      (local-name()='intensity' and (.='1' or .='1.0')) or
                      (local-name()='location' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='priority' and (.='0' or .='0.0')) or
                      (local-name()='maxBack' and (.='10' or .='10.0')) or
                      (local-name()='maxFront' and (.='10' or .='10.0')) or
                      (local-name()='minBack' and (.='1' or .='1.0'))  or
                      (local-name()='minFront' and (.='1' or .='1.0')) or
                      (local-name()='spatialize' and .='true'))) and
                      not( local-name(..)='Sphere' and ((local-name()='radius' and (.='1' or .='1.0')) or (local-name()='solid' and .='true'))) and
                      not( local-name(..)='SphereSensor' and
                      ((local-name()='autoOffset' and .='true') or
                      (local-name()='enabled' and .='true') or
                      (local-name()='offset' and (.='0 1 0 0' or .='0.0 1.0 0.0 0.0')) and
                      not( local-name(..)='Switch' and ../IS/connect[@nodeField='whichChoice'])))" />
        <!-- Switch whichChoice='-1' is very significant and somewhat counterintuitive/nonobvious, so otherwise show it. -->
        <!--	  and not( local-name(..)='Switch' and  local-name()='whichChoice' and (.='-1' or .='-1.0')) -->
        <xsl:variable name="notDefaultFieldValue6"
                      select="not( local-name(..)='SpotLight'	and
                      ((local-name()='ambientIntensity' and (.='0' or .='0.0')) or
                      (local-name()='attenuation' and (.='1 0 0' or .='1.0 0.0 0.0')) or
                      (local-name()='beamWidth' and ((.='0.785398') or (.='0.7854') or (.='.785398') or (.='.7854'))) or
                      (local-name()='color' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='cutOffAngle' and (.='1.5708' or .='1.570796')) or
                      (local-name()='direction' and (.='0 0 -1' or .='0.0 0.0 -1.0')) or
                      (local-name()='global' and .='true') or
                      (local-name()='intensity' and (.='1' or .='1.0')) or
                      (local-name()='location' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='on' and .='true') or
                      (local-name()='radius' and (.='100' or .='100.0')))) and
                      not( local-name(..)='Text'   and ((local-name()='maxExtent' and (.='0' or .='0.0')) or (local-name()='solid' and (.='false')))) and
                      not( local-name(..)='TextureTransform' and
                      ((local-name()='center' and (.='0 0' or .='0.0 0.0')) or
                      (local-name()='rotation' and (.='0' or .='0.0')) or
                      (local-name()='scale' and (.='1 1' or .='1.0 1.0')) or
                      (local-name()='translation' and (.='0 0' or .='0.0 0.0')))) and
                      not( local-name(..)='TextureTransform3D' and
                      ((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='TextureTransformMatrix3D' and
                      ((local-name()='matrix' and (.='1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1' or .='1.0 0.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 0.0 1.0'))))" />
        <xsl:variable name="notDefaultFieldValue7"
                      select="not( local-name(..)='TimeSensor' and
                      ((local-name()='cycleInterval' and (.='1' or .='1.0')) or
                      (local-name()='enabled' and .='true') or
                      (local-name()='startTime' and (.='0' or .='0.0')) or
                      (local-name()='stopTime' and (.='0' or .='0.0')) or
                      (local-name()='pauseTime' and (.='0' or .='0.0')) or
                      (local-name()='resumeTime'  and (.='0' or .='0.0')) or
                      (local-name()='loop' and .='false'))) and
                      not(contains(local-name(..),'TouchSensor') and
                      local-name()='enabled' and .='true') and
                      not( ((local-name(..)='Transform') or (local-name(..)='EspduTransform') or (local-name(..)='GeoTransform')) and
                      ((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
					  (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                      (local-name()='scaleOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='Viewpoint' and
                      (local-name()='fieldOfView' and ((.='0.785398') or (.='0.7854') or (.='.785398') or (.='.7854')))) and
                      not( local-name(..)='OrthoViewpoint' and
                      (local-name()='fieldOfView' and ((.='-1 -1 1 1') or (.='-1.0 -1.0 1.0 1.0')))) and
                      not( contains(local-name(..),'Viewpoint') and
                      ((local-name()='centerOfRotation' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='jump' and .='true') or
                      (local-name()='orientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                      (local-name()='retainUserOffsets' and (.='false')) or
                      (local-name()='position' and (.='0 0 10' or .='0.0 0.0 10.0')))) and
                      not( local-name(..)='VisibilitySensor' and
                      ((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='enabled' and .='true') or
                      (local-name()='size' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='enterTime' and (.='0' or .='0.0')) or
                      (local-name()='exitTime'  and (.='0' or .='0.0')) or
                      (local-name()='isActive' and .='false')))" />
        <xsl:variable name="notDefaultFieldValue8"
                      select="not( local-name(..)='FillProperties' and
                      (((local-name()='filled' and .='true') or
                      (local-name()='hatched' and .='true') or
                      local-name()='hatchStyle' and (.='1' or .='1.0')) or
                      (local-name()='hatchColor' and (.='1 1 1' or .='1.0 1.0 1.0')))) and
                      not( local-name(..)='LineProperties' and
                      ((local-name()='applied' and .='true') or
                      (local-name()='linetype' and (.='1')) or
                      (local-name()='linewidthScaleFactor' and (.='0' or .='0.0')))) and
                      not( local-name(..)='ClipPlane' and
                      ((local-name()='enabled' and .='true') or
                      (local-name()='plane' and (.='0 1 0 0' or .='0.0 1.0 0.0 0.0')))) and
                      not( local-name(..)='ViewpointGroup' and
                      ((local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='displayed' and .='true') or
                      (local-name()='retainUserOffsets' and .='false') or
                      (local-name()='size' and (.='0 0 0' or .='0.0 0.0 0.0'))))" />
        <xsl:variable name="notDefaultFieldValue9"
                      select="not( local-name(..)='MultiTexture' and
                      ((local-name()='alpha' and (.='1' or .='1.0')) or
                      (local-name()='color' and (.='1 1 1' or .='1.0 1.0 1.0')))) and
                      not( local-name(..)='TextureCoordinateGenerator' and
                      ((local-name()='mode' and .='SPHERE'))) and
                      not((local-name(..)='ComposedTexture3D' or local-name(..)='ImageTexture3D' or local-name(..)='PixelTexture3D') and
                      ((local-name()='repeatS' or local-name()='repeatT' or local-name()='repeatR') and .='false')) and
                      not( local-name(..)='PixelTexture3D' and
                      (local-name()='image' and (.='0 0 0 0'))) and
                      not( local-name(..)='IntegerTrigger' and
                      ((local-name()='integerKey' and .='-1'))) and
                      not( local-name(..)='LayerSet' and
                      ((local-name()='activeLayer' and .='0') or
                       (local-name()='order' and .='0'))) and
                      not(contains(local-name(..),'PickSensor') and
                      ((local-name()='enabled' and .='true') or
                       (local-name()='intersectionType' and .='BOUNDS') or
                       (local-name()='matchCriterion' and .='MATCH_ANY') or
                       (local-name()='objectType' and .='&quot;ALL&quot;') or
                       (local-name()='sortOrder' and .='CLOSEST'))) and
                      not( local-name(..)='ParticleSystem' and
                      ((local-name()='createParticles' and .='true') or
                       (local-name()='enabled' and .='true') or
                       (local-name()='geometryType' and .='QUAD') or
                       (local-name()='lifetimeVariation' and .='0.25') or
                       (local-name()='maxParticles' and .='200') or
                       (local-name()='particleLifetime' and .='5') or
                       (local-name()='particleSize' and .='0.02 0.02'))) and
                      not( local-name(..)='PickableGroup' and
                      ((local-name()='objectType' and .='&quot;ALL&quot;') or
                       (local-name()='pickable' and .='true'))) and
                      not(local-name(..)='StringSensor' and
                      ((local-name()='deletionAllowed' or local-name()='enabled') and (.='true'))) and
                      not( local-name(..)='TransformSensor' and
                      ((local-name()='enabled' and .='true') or
                       (local-name()='size' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='GeneratedCubeMapTexture' and
                      ((local-name()='update' and .='NONE') or
                       (local-name()='size' and .='128'))) and
                      not(local-name(..)='MovieTexture' and
                      ((local-name()='pitch' or local-name()='1') and (.='1.0'))) and
                      not(contains(local-name(..),'Emitter') and
                      ((local-name()='angle' and .='0.7854') or
                       (local-name()='direction' and (.='0 1 0' or .='0.0 1.0 0.0')) or
                       (local-name()='mass' and (.='0' or .='0.0')) or
                       (local-name()='position' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='speed' and (.='0' or .='0.0')) or
                       (local-name()='surfaceArea' and (.='0' or .='0.0')) or
                       (local-name()='variation' and .='0.25') or
                       (local-name()='internal' and .='true') or
                       (local-name()='coordIndex' or local-name()='-1'))) and
                      not(local-name(..)='Contact' and
                      ((local-name()='minBounceSpeed' and (.='0' or .='0.0')))) and
                      not(contains(local-name(..),'Layer') and
                      ((local-name()='isPickable' and .='true'))) and
                      not(contains(local-name(..),'Layout') and
                      ((local-name()='offset' and (.='0 0' or .='0.0 0.0')) or
                       (local-name()='size'   and (.='1 1' or .='1.0 1.0')) or
                       (local-name()='align' and .='&quot;CENTER&quot; &quot;CENTER&quot;') or
                       (local-name()='offsetUnits' and .='&quot;WORLD&quot; &quot;WORLD&quot;') or
                       (local-name()='scaleMode' and .='&quot;NONE&quot; &quot;NONE&quot;') or
                       (local-name()='sizeUnits' and .='&quot;WORLD&quot; &quot;WORLD&quot;'))) and
                      not( local-name(..)='TextureProperties' and
                      ((local-name()='anisotropicDegree' and (.='1' or .='1.0')) or
                       (local-name()='borderColor' and (.='0 0 0 0' or .='0.0 0.0 0.0 0.0')) or
                       (local-name()='borderWidth' and (.='0' or .='0.0')) or
                       (starts-with(local-name(),'boundaryMode') and .='REPEAT') or
                       (local-name()='generateMipMaps' and .='false') or
                       (local-name()='magnificationFilter' and .='FASTEST') or
                       (local-name()='minificationFilter'  and .='FASTEST') or
                       (local-name()='textureCompression'  and .='FASTEST') or
                       (local-name()='texturePriority' and (.='0' or .='0.0')))) and
                      not(local-name(..)='Viewport' and
                      ((local-name()='clipBoundary' and (.='0 1 0 1' or .='0.0 1.0 0.0 1.0')))) and
                      not( local-name(..)='KeySensor' and
                      ((local-name()='enabled' and .='true')))" />
        <xsl:variable name="notDefaultContainerField1"
                      select="not((local-name()='containerField' and .='children')	and
                      (contains(local-name(..),'Interpolator') or
                      contains(local-name(..),'Light') or
                      contains(local-name(..),'Sensor') or
                      local-name(..)='Anchor' or
                      local-name(..)='Background' or
                      local-name(..)='Billboard' or
                      local-name(..)='Collision' or
                      local-name(..)='Fog' or
                      local-name(..)='Group' or
                      local-name(..)='Inline' or
                      local-name(..)='LOD' or
                      local-name(..)='NavigationInfo' or
                      local-name(..)='Script' or
                      local-name(..)='Shape' or
                      local-name(..)='Sound' or
                      local-name(..)='Switch' or
                      local-name(..)='TextureBackground' or
                      local-name(..)='Transform' or
                      local-name(..)='Viewpoint' or
                      local-name(..)='WorldInfo' or
                      local-name(..)='ProtoInstance')) and
                      not((local-name()='containerField' and .='geometry')	and
                      (local-name(..)='Box' or
                      local-name(..)='Cone' or
                      local-name(..)='Cylinder' or
                      local-name(..)='ElevationGrid' or
                      local-name(..)='GeoElevationGrid' or
                      local-name(..)='Extrusion' or
                      local-name(..)='IndexedFaceSet' or
                      local-name(..)='IndexedLineSet' or
                      local-name(..)='PointSet' or
                      local-name(..)='Sphere' or
                      local-name(..)='Text' or
                      local-name(..)='XvlShell'))" />
        <xsl:variable name="notDefaultContainerField2"
                      select="not((local-name()='containerField' and .='source')	and (local-name(..)='AudioClip')) and
                      not((local-name()='containerField' and .='appearance')	and (local-name(..)='Appearance')) and
                      not((local-name()='containerField' and .='material')	and ((local-name(..)='Material') or (local-name(..)='TwoSidedMaterial'))) and
                      not((local-name()='containerField' and .='color')	and (local-name(..)='Color' or local-name(..)='ColorRGBA')) and
                      not((local-name()='containerField' and .='coord')	and ((local-name(..)='Coordinate') or (local-name(..)='CoordinateDouble') or (local-name(..)='GeoCoordinate'))) and
                      not((local-name()='containerField' and .='normal')	and (local-name(..)='Normal')) and
                      not((local-name()='containerField' and .='texture')	and (local-name(..)='ImageTexture' or local-name(..)='PixelTexture' or local-name(..)='MovieTexture' or local-name(..)='MultiTexture' or local-name(..)='ComposedTexture3D' or local-name(..)='ImageTexture3D' or local-name(..)='PixelTexture3D')) and
                      not((local-name()='containerField' and .='fontStyle')	and (local-name(..)='FontStyle')) and
                      not((local-name()='containerField' and .='texCoord')	and (local-name(..)='TextureCoordinate' or local-name(..)='TextureCoordinateGenerator')) and
                      not((local-name()='containerField' and .='textureTransform')	and (local-name(..)='TextureTransform'))" />
        <xsl:variable name="notDefaultContainerField3"
                      select="not((local-name()='containerField' and .='geometry')	and
                      ((local-name(..)='Arc2D') or (local-name(..)='ArcClose2D') or (local-name(..)='Circle2D') or (local-name(..)='Disk2D') or (local-name(..)='Polyline2D') or (local-name(..)='Polypoint2D') or (local-name(..)='Rectangle2D') or (local-name(..)='TriangleSet2D') or contains(local-name(..),'QuadSet'))) and
                      not((local-name()='containerField' and .='voxels')	and
                      ((local-name(..)='IsoSurfaceVolumeData') or (local-name(..)='SegmentedVolumeData') or (local-name(..)='VolumeData'))) and
                      not((local-name()='containerField' and .='renderStyle')	and
                      ((local-name(..)='BlendedVolumeStyle') or (local-name(..)='BoundaryEnhancementVolumeStyle') or (local-name(..)='CartoonVolumeStyle') or (local-name(..)='ComposedVolumeStyle') or (local-name(..)='EdgeEnhancementVolumeStyle') or (local-name(..)='OpacityMapVolumeStyle') or (local-name(..)='ProjectionVolumeStyle') or (local-name(..)='ShadedVolumeStyle') or (local-name(..)='SilhouetteEnhancementVolumeStyle') or (local-name(..)='ToneMappedVolumeStyle')))" />
        <xsl:variable name="notDefaultCAD"
                      select="not((local-name(..)='CADAssembly' or local-name(..)='CADFace' or local-name(..)='CADLayer') and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='bboxCenter' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='bboxSize' and (.='-1 -1 -1' or .='-1.0 -1.0 -1.0')))) and
                      not(local-name(..)='CADPart' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='bboxCenter' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='bboxSize' and (.='-1 -1 -1' or .='-1.0 -1.0 -1.0')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
					   (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0 1 0 0.0'  or .='0 0 1 0.0' or .='0.0 1.0 0.0 0.0')) or
                       (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                       (local-name()='scaleOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0'))))" />
        <xsl:variable name="notDefaultDIS1"
                      select="not((local-name(..)='EspduTransform' or contains(local-name(..),'Pdu')) and
                      ((starts-with(local-name(),'is')) or
                      (local-name()='address' and (.='localhost')) or
                      (local-name()='enabled' and (.='true')) or
                      (local-name()='networkMode' and (.='standAlone')) or
                      (local-name()='rtpHeaderExpected' and (.='false')) or
                      (local-name()='readInterval'  and (.='.1' or .='0.1')) or
                      (local-name()='writeInterval'  and (.='1' or .='1.0')) or
                      (((local-name()='applicationID') or (local-name()='munitionApplicationID') or (local-name()='whichGeometry')) and (.='1')) or
                      ((contains(local-name(),'ntityID') or contains(local-name(),'iteID') or (local-name()='applicationID')) and (.='0')) or
                      ((local-name()='port' or local-name()='multicastRelayPort' or local-name()='fireMissionIndex') and (.='0'))))" />
        <!-- ='' ='1' '' geoCoords='0 0 0' geoSystem='"GD" "WE"' '1' munitionSiteID='0' ='' '0' '0' -->
        <xsl:variable name="notDefaultDIS2"
                      select="not(local-name(..)='EspduTransform' and
                      ((((local-name()='collisionType') or (local-name()='detonationResult')) and (.='0')) or
                      (((local-name()='detonationLocation') or (local-name()='detonationRelativeLocation'))  and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='eventApplicationID'  and (.='1')) or
                      (((local-name()='eventEntityID') or (local-name()='eventNumber') or (local-name()='eventSiteID'))  and (.='0')) or
                      ((local-name()='fired1' or local-name()='fired2') and (.='false')) or
                      (local-name()='deadReckoning'  and (.='0')) or
                      ((local-name()='articulationParameterCount' or local-name()='entityCategory' or local-name()='entitySubcategory' or local-name()='entityCountry' or local-name()='entityDomain' or local-name()='entityExtra' or local-name()='entityKind' or local-name()='entitySpecific' or local-name()='eventApplicationID' or local-name()='firingRange' or local-name()='firingRate' or local-name()='fuse' or local-name()='warhead' or local-name()='forceID' or local-name()='munitionQuantity' or local-name()='munitionApplicationID') and (.='0')) or
                      ((local-name()='linearVelocity' or local-name()='linearAcceleration' or local-name()='munitionStartPoint' or local-name()='munitionEndPoint') and (.='0 0 0'))))" />
        <xsl:variable name="notDefaultDIS3"
                      select="not(local-name(..)='ReceiverPdu' and 
                      (((local-name()='radioID' or local-name()='receiverState' or starts-with(local-name(),'transmitter')) and (.='0')) or
                      (local-name()='receivedPower'  and (.='0' or .='0.0')))) and
                      not(local-name(..)='SignalPdu' and
                      (((local-name()='radioID' or local-name()='encodingScheme' or local-name()='tdlType' or local-name()='sampleRate' or local-name()='samples' or local-name()='dataLength') and (.='0')))) and
                      not(local-name(..)='TransmitterPdu' and
                      (((local-name()='radioID' or starts-with(local-name(),'antennaPattern') or starts-with(local-name(),'crypto') or local-name()='frequency' or local-name()='inputSource' or local-name()='lengthOfModulationParameters' or starts-with(local-name(),'modulationType') or starts-with(local-name(),'radioEntityType') or local-name()='transmitFrequencyBandwidth' or local-name()='transmitState') and (.='0')) or
                      ((local-name()='power' or local-name()='transmitFrequencyBandwidth') and (.='0' or .='0.0')) or
                      ((contains(local-name(),'ntennaLocation') and (.='0 0 0')))))" />
        <xsl:variable name="notDefaultDIS4"
                      select="not(local-name(..)='DISEntityManager' and
                      (((local-name()='applicationID') and (.='0')) or
                      (local-name()='address' and (.='localhost')) or
                      ((local-name()='port' or local-name()='siteID') and (.='0')))) and
                      not(local-name(..)='DISEntityTypeMapping' and 
                      ((local-name()='containerField') and (.='mapping')) or
                      ((local-name()='category' or local-name()='country' or local-name()='domain' or local-name()='extra' or local-name()='kind' or local-name()='specific' or local-name()='subcategory') and (.='0')))" />
        <xsl:variable name="notDefaultGeo"
                      select="not((starts-with(local-name(..),'Geo') or (local-name(..)='EspduTransform') or contains(local-name(..),'Pdu')) and 
                      ((local-name()='geoCenter' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='geoCoords' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='geoSystem' and (translate(.,',','')='&quot;GD&quot; &quot;WE&quot;')))) and
                      not(local-name(..)='GeoLOD' 	  and 
                      ((local-name()='range' and (.='10' or .='10.0')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not(local-name(..)='GeoViewpoint' and
                      ((local-name()='speedFactor' and (.='1' or .='1.0')) or
                       (local-name()='headlight' and (.='true')) or
                       (local-name()='jump' and (.='true')) or
                       (local-name()='navType' and (.='&quot;EXAMINE&quot; &quot;ANY&quot;')) or
                       (local-name()='orientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='position' and (.='0 0 100000' or .='0.0 0.0 100000.0')) or
                      (local-name()='fieldOfView' and (.='0.785398' or .='.785398' or .='0.7854' or .='.7854')))) and
                      not((local-name(..)='GeoCoordinate' or local-name(..)='GeoOrigin') and
                      ((local-name()='rotateYUp' and (.='false')) or
                      (local-name()='containerField' and (.='geoOrigin')) or
                      (local-name()='geoSystem' and (translate(.,',','')='&quot;GD&quot; &quot;WE&quot;'))))" />
        <xsl:variable name="notDefaultHAnim1"
                      select="not( local-name(..)='HAnimJoint' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='limitOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                       (local-name()='scaleOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='stiffness' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                       (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='HAnimSegment' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='bboxCenter' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='bboxSize' and (.='-1 -1 -1' or .='-1.0 -1.0 -1.0')) or
                       (local-name()='centerOfMass' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='mass' and (.='0' or .='0.0')) or
                       (local-name()='momentsOfInertia' and
                        (.='0 0 0 0 0 0 0 0 0' or .='0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0')))) and
                      not( local-name(..)='HAnimSite' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                       (local-name()='scaleOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0'))))" />
        <xsl:variable name="notDefaultHAnim2"
                      select="not( local-name(..)='HAnimHumanoid' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='bboxCenter' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='bboxSize' and (.='-1 -1 -1' or .='-1.0 -1.0 -1.0')) or
                       (local-name()='center' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                       (local-name()='rotation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='scale' and (.='1 1 1' or .='1.0 1.0 1.0')) or
                       (local-name()='scaleOrientation' and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')) or
                       (local-name()='translation' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not( local-name(..)='HAnimDisplacer' and
                      ((local-name()='containerField' and (.='children')) or
                       (local-name()='weight' and (.='0' or .='0.0'))))" />
        <xsl:variable name="notDefaultNurbs"
                      select="not((local-name(..)='NurbsCurve' or local-name(..)='NurbsCurve2D') and
                      ((local-name()='tessellation' and (.='0')) or
                      (local-name()='closed' and (.='false')) or
                      (local-name()='order' and (.='3')))) and
                      not(local-name(..)='NurbsSet' and
                      ((local-name()='tessellationScale' and (.='1' or .='1.0')) or 
                      (local-name()='bboxCenter'	and	(.='0 0 0' or .='0.0 0.0 0.0')) or
                      ( local-name()='bboxSize'	and	(.='-1 -1 -1' or .='-1.0 -1.0 -1.0')))) and
                      not((local-name(..)='NurbsOrientationInterpolator' or local-name(..)='NurbsPositionInterpolator') and
                      ((local-name()='order' and (.='3' or .='3.0')))) and
                      not((local-name(..)='NurbsSurface' or local-name(..)='NurbsPatchSurface' or local-name(..)='NurbsSweptSurface' or local-name(..)='NurbsTextureSurface' or local-name(..)='NurbsTrimmedSurface') and
                      ((local-name()='uTessellation' and (.='0')) or
                      (local-name()='vTessellation' and (.='0')) or
                      (local-name()='uDimension' and (.='0')) or
                      (local-name()='vDimension' and (.='0')) or
                      (local-name()='uOrder' and (.='3')) or
                      (local-name()='vOrder' and (.='3')) or
                      (local-name()='ccw' and (.='true')) or
                      (local-name()='solid' and (.='true')) or
                      ((local-name()='uClosed' or local-name()='vClosed') and (.='false')))) and
                      not((local-name(..)='NurbsSurfaceInterpolator' or local-name(..)='NurbsTextureCoordinate') and
                      ((local-name()='uDimension' and (.='0')) or
                      (local-name()='vDimension' and (.='0')) or
                      (local-name()='uOrder' and (.='3')) or
                      (local-name()='vOrder' and (.='3')))) and
                      not((local-name(..)='NurbsCurve' or local-name(..)='NurbsSwungSurface') and
                      ((local-name()='ccw' or local-name()='solid') and (.='true'))) and
                      not((contains(local-name(..),'SplinePositionInterpolator') or local-name(..)='SplineScalarInterpolator' or local-name(..)='SquadOrientationInterpolator') and
                      ((local-name()='closed' or local-name()='normalizeVelocity') and (.='false')))" />
        <xsl:variable name="notDefaultGeometry2D"
                      select="not((local-name(..)='Arc2D' or local-name(..)='ArcClose2D') and
                      ((local-name()='startAngle' and (.='0' or .='0.0')) or
                       (local-name()='endAngle' and (.='1.5708' or .='1.570796')) or
                       (local-name()='radius' and (.='1' or .='1.0')) or
                       (local-name()='solid' and (.='false')) or
                       (local-name()='closureType' and (.='PIE')))) and
                      not(local-name(..)='Circle2D' and
                      ((local-name()='radius' and (.='1' or .='1.0')))) and
                      not(local-name(..)='Disk2D' and
                      ((local-name()='innerRadius' and (.='0' or .='0.0')) or
                       (local-name()='outerRadius' and (.='1' or .='1.0')) or
                       (local-name()='solid' and (.='false')))) and
                      not((local-name(..)='Rectangle2D') and
                      ((local-name()='size' and ((.='2 2') or (.='2.0 2.0'))) or
                       (local-name()='solid' and (.='false')))) and
                      not((local-name(..)='TriangleSet2D') and
                      ((local-name()='solid' and (.='false'))))" />
        <xsl:variable name="notDefaultVolume"
                      select="not(((local-name(..)='IsoSurfaceVolumeData') or (local-name(..)='SegmentedVolumeData') or (local-name(..)='VolumeData'))	and
                      ((local-name()='dimensions' and (.='1 1 1' or .='1.0 1.0 1.0')) or 
                      (local-name()='bboxCenter'	and	(.='0 0 0' or .='0.0 0.0 0.0')) or
                      ( local-name()='bboxSize'	and	(.='-1 -1 -1' or .='-1.0 -1.0 -1.0')))) and
                      not((local-name(..)='IsoSurfaceVolumeData')	and
                      ((local-name()='contourStepSize' or local-name()='surfaceTolerance') and (.='0' or .='0.0'))) and
                      not(((local-name(..)='BlendedVolumeStyle') or (local-name(..)='BoundaryEnhancementVolumeStyle') or (local-name(..)='CartoonVolumeStyle') or (local-name(..)='ComposedVolumeStyle') or (local-name(..)='EdgeEnhancementVolumeStyle') or (local-name(..)='OpacityMapVolumeStyle') or (local-name(..)='ProjectionVolumeStyle') or (local-name(..)='ShadedVolumeStyle') or (local-name(..)='SilhouetteEnhancementVolumeStyle') or (local-name(..)='ToneMappedVolumeStyle')) and
                      (local-name()='enabled' and .='true')) and
                      not((local-name(..)='BlendedVolumeStyle')	and
                      (((local-name()='weightConstant1' or local-name()='weightConstant2') and (.='.5' or .='0.5')) or
                       ((local-name()='weightFunction1' or local-name()='weightFunction2') and (.='CONSTANT')))) and
                      not((local-name(..)='BoundaryEnhancementVolumeStyle')	and
                      (((local-name()='boundaryOpacity') and (.='.9' or .='0.9')) or
                       ((local-name()='opacityFactor') and (.='2' or .='2.0')) or
                       ((local-name()='retainedOpacity') and (.='.2' or .='0.2')))) and
                      not((local-name(..)='CartoonVolumeStyle')	and
                      (((local-name()='colorSteps') and (.='4')) or
                       ((local-name()='orthogonalColor') and (.='1 1 1 1' or .='1.0 1.0 1.0 1.0')) or
                       ((local-name()='parallelColor') and (.='0 0 0 1' or .='0.0 0.0 0.0 1.0')))) and
                      not((local-name(..)='EdgeEnhancementVolumeStyle')	and
                      (((local-name()='gradientThreshold') and (.='.4' or .='0.4')) or
                       ((local-name()='edgeColor') and (.='0 0 0 1' or .='0.0 0.0 0.0 1.0')))) and
                      not((local-name(..)='IsoSurfaceVolumeData')	and
                      (((local-name()='surfaceTolerance') and (.='0' or .='0.0')))) and
                      not((local-name(..)='ProjectionVolumeStyle')	and
                      (((local-name()='intensityThreshold') and (.='0' or .='0.0')) or
                       ((local-name()='type') and (.='MAX')))) and
                      not((local-name(..)='ShadedVolumeStyle')	and
                      (((local-name()='lighting' or local-name()='shadows') and (.='false')) or
                       ((local-name()='phaseFunction') and (.='Henyey-Greenstein')))) and
                      not((local-name(..)='SilhouetteEnhancementVolumeStyle')	and
                      (((local-name()='silhouetteBoundaryOpacity') and (.='0' or .='0.0')) or
                       ((local-name()='silhouetteRetainedOpacity') and (.='1' or .='1.0')) or
                       ((local-name()='silhouetteSharpness') and (.='.5' or .='0.5')))) and
                      not((local-name(..)='ToneMappedVolumeStyle')	and
                      (((local-name()='colorSteps') and (.='4')) or
                       ((local-name()='coolColor') and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0')) or
                       ((local-name()='warmColor') and (.='1 1 0 0' or .='1.0 1.0 0.0 0.0'))))" />
        <xsl:variable name="notDefaultFollower"
                      select="not(contains(local-name(..),'Chaser') and
                      ((local-name()='duration' and (.='1' or .='1.0')))) and
                      not(contains(local-name(..),'Damper') and
                      ((local-name()='tau' and (.='.3' or .='0.3')) or
                      (local-name()='tolerance' and (.='-1' or .='-1.0')) or
                      (local-name()='order ' and (.='3')))) and
                      not(contains(local-name(..),'Damper') and
                      (local-name()='order' and (.='3'))) and
                      not((local-name(..)='ColorChaser' or local-name(..)='ColorDamper') and
                      ((local-name()='initialDestination' and (.='.8 .8 .8' or .='0.8 0.8 0.8')) or
                      (local-name()='initialValue' and (.='.8 .8 .8' or .='0.8 0.8 0.8')))) and
                      not((local-name(..)='CoordinateChaser' or local-name(..)='CoordinateDamper' or local-name(..)='PositionChaser' or local-name(..)='PositionDamper') and
                      ((local-name()='initialDestination' and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='initialValue' and (.='0 0 0' or .='0.0 0.0 0.0')))) and
                      not((local-name(..)='PositionChaser2D' or local-name(..)='PositionDamper2D') and
                      ((local-name()='initialDestination' and (.='0 0' or .='0.0 0.0')) or
                      (local-name()='initialValue' and (.='0 0' or .='0.0 0.0')))) and
                      not((local-name(..)='OrientationChaser' or local-name(..)='OrientationDamper') and
                      ((local-name()='initialDestination' and (.='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 0 1 0' or .='0.0 0.0 1.0 0.0')) or
                      (local-name()='initialValue' and (.='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 0 1 0' or .='0.0 0.0 1.0 0.0')))) and
                      not((local-name(..)='ScalarChaser' or local-name(..)='ScalarDamper') and
                      ((local-name()='initialDestination' and (.='0' or .='0.0')) or
                      (local-name()='initialValue' and (.='0' or .='0.0'))))" />
        <xsl:variable name="notDefaultShader"
                      select="not((local-name(..)='FloatVertexAttribute') and ((local-name()='numComponents' and (.='4'))))" />
		              <!-- retained due to importance:
                      and
                      not((local-name(..)='ShaderPart' or local-name(..)='ShaderProgram') and ((local-name()='type' and (.='VERTEX')))) -->
        <xsl:variable name="notDefaultRigidBodyPhysics"
                      select="not((local-name(..)='CollidableOffset' or local-name(..)='CollidableShape') and
                      (((local-name()='enabled') and (.='true')) or
                      ((local-name()='rotation') and (.='0 0 1 0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0.0 0.0 1.0 0.0')) or
                      ((local-name()='translation') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='bboxCenter')	and	(.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='bboxSize')	and	(.='-1 -1 -1' or .='-1.0 -1.0 -1.0')))) and
                      not((local-name(..)='CollisionSpace') and
                      ((local-name()='enabled' and (.='true')) or
                      (local-name()='useGeometry' and (.='false')) or
                      (local-name()='bboxCenter'	and	(.='0 0 0' or .='0.0 0.0 0.0')) or
                      (local-name()='bboxSize'	and	(.='-1 -1 -1' or .='-1.0 -1.0 -1.0')))) and
                      not((local-name(..)='BallJoint' or local-name(..)='DoubleAxisHingeJoint' or local-name(..)='MotorJoint' or local-name(..)='SingleAxisHingeJoint' or local-name(..)='SliderJoint' or local-name(..)='UniversalJoint') and
                      ((local-name()='forceOutput')	and	(.='&quot;NONE&quot;'))) and
                      not((local-name(..)='BallJoint') and
                      ((local-name()='anchorPoint')	and	(.='0 0 0' or .='0.0 0.0 0.0'))) and
                      not((local-name(..)='BoundedPhysicsModel') and
                      ((local-name()='enabled')	and	(.='true'))) and
                      not((local-name(..)='ForcePhysicsModel') and
                      ((local-name()='enabled')	and	(.='true')) or
                      (local-name()='force'	and	(.='0 -9.8 0' or .='0.0 -9.8 0.0'))) and
                      not((local-name(..)='WindPhysicsModel') and
                      ((local-name()='enabled')	and	(.='true')) or
                      (local-name()='gustiness'	and	(.='0.1')) or
                      (local-name()='speed'	and	(.='0.1')) or
                      (local-name()='turbulence'	and	(.='0' or .='0.0')) or
                      (local-name()='direction'	and	(.='1 0 0' or .='1.0 0.0 0.0'))) and
                      not((local-name(..)='CollisionCollection') and
                      (((local-name()='appliedParameters') and (.='&quot;BOUNCE&quot;')) or
                      ((local-name()='bounce') and (.='0' or .='0.0')) or
                      ((local-name()='enabled') and (.='true')) or
                      ((local-name()='frictionCoefficients' or local-name()='slipFactors' or local-name()='surfaceSpeed') and (.='0 0' or .='0.0 0.0')) or
                      ((local-name()='minBounceSpeed') and (.='.1' or .='0.1')) or
                      ((local-name()='softnessConstantForceMix') and (.='.0001' or .='0.0001')) or
                      ((local-name()='softnessErrorCorrection') and (.='.8' or .='0.8')))) and
                      not((local-name(..)='CollisionSensor') and
                      (local-name()='enabled' and .='true')) and
                      not((local-name(..)='Contact') and
                      (((local-name()='appliedParameters') and (.='&quot;BOUNCE&quot;')) or
                      ((local-name()='bounce' or local-name()='depth' or local-name()='minbounceSpeed') and (.='0' or .='0.0')) or
                      ((local-name()='contactNormal') and (.='0 1 0' or .='0.0 1.0 0.0')) or
                      ((local-name()='frictionCoefficients' or local-name()='slipCoefficients' or local-name()='surfaceSpeed') and (.='0 0' or .='0.0 0.0')) or
                      ((local-name()='frictionDirection') and (.='0 1 0' or .='0.0 1.0 0.0')) or
                      ((local-name()='position') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='softnessConstantForceMix') and (.='.0001' or .='0.0001')) or
                      ((local-name()='softnessErrorCorrection') and (.='.8' or .='0.8')))) and
                      not((local-name(..)='DoubleAxisHingeJoint') and
                      (((local-name()='anchorPoint' or local-name()='axis1' or local-name()='axis2') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='desiredAngularVelocity1' or local-name()='desiredAngularVelocity2' or local-name()='maxTorque1' or local-name()='maxTorque2' or local-name()='stop1Bounce' or local-name()='suspensionForce') and (.='0' or .='0.0')) or
                      ((local-name()='maxAngle1') and (.= '3.1416' or .= '3.14159' or .= '3.141593' or .= '3.1415926' or .= '3.14159263' or .= '3.141592653')) or
                      ((local-name()='minAngle1') and (.='-3.1416' or .='-3.14159' or .='-3.141593' or .='-3.1415926' or .='-3.14159263' or .='-3.141592653')) or
                      ((local-name()='stop1Bounce') and (.='0' or .='0.0')) or
                      ((local-name()='stop1ConstantForceMix') and (.='.001' or .='0.001')) or
                      ((local-name()='stop1ErrorCorrection' or local-name()='suspensionErrorCorrection') and (.='.8' or .='0.8')))) and
                      not((local-name(..)='MotorJoint') and
                      (((local-name()='axis1Angle' or local-name()='axis2Angle' or local-name()='axis3Angle' or local-name()='axis1Torque' or local-name()='axis2Torque' or local-name()='axis3Torque' or local-name()='stop1Bounce' or local-name()='stop2Bounce' or local-name()='stop3Bounce') and (.='0' or .='0.0')) or
                      ((local-name()='stop1ErrorCorrection' or local-name()='stop2ErrorCorrection' or local-name()='stop3ErrorCorrection') and (.='.8' or .='0.8')) or
                      ((local-name()='motor1Axis' or local-name()='motor2Axis' or local-name()='motor3Axis') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='enabledAxes') and (.='1')) or
                      ((local-name()='autoCalc') and (.='false')))) and
                      not((local-name(..)='RigidBody') and
                      (((local-name()='angularDampingFactor') and (.='.001' or .='0.001')) or
                      ((local-name()='angularVelocity' or local-name()='centerOfMass' or local-name()='finiteRotationAxis' or local-name()='linearVelocity' or local-name()='position') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='disableAngularSpeed' or local-name()='disableLinearSpeed' or local-name()='disableTime') and (.='0' or .='0.0')) or
                      ((local-name()='finiteRotationAxis') and (.='0 1 0' or .='0.0 1.0 0.0')) or
                      ((local-name()='mass') and (.='1' or .='1.0')) or
                      ((local-name()='enabled' or local-name()='useGlobalGravity') and (.='true')) or
                      ((local-name()='autoDamp' or local-name()='autoDisable' or local-name()='fixed' or local-name()='useFiniteRotation') and (.='false')) or
                      ((local-name()='inertia') and (.='1 0 0 0 1 0 0 0 1' or .='1.0 0 0 0 1.0 0 0 0 1.0' or .='1.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 1.0')) or
                      ((local-name()='linearDampingFactor') and (.='.001' or .='0.001')) or
                      ((local-name()='orientation') and (.='0 0 1 0' or .='0.0 0.0 1.0 0.0' or .='0 1 0 0' or .='0.0 1.0 0.0 0.0' or .='0 1 0 0.0'  or .='0 0 1 0.0')))) and
                      not((local-name(..)='RigidBodyCollection') and
                      (((local-name()='autoDisable' or local-name()='preferAccuracy') and (.='false')) or
                      ((local-name()='enabled') and (.='true')) or
                      ((local-name()='constantForceMix') and (.='.0001' or .='0.0001')) or
                      ((local-name()='contactSurfaceThickness' or local-name()='disableAngularSpeed' or local-name()='disableLinearSpeed' or local-name()='disableTime') and (.='0' or .='0.0')) or
                      ((local-name()='errorCorrection') and (.='.8' or .='0.8')) or
                      ((local-name()='gravity') and (.='0 -9.8 0' or .='0.0 -9.8 0.0')) or
                      ((local-name()='iterations') and (.='10')) or
                      ((local-name()='maxCorrectionSpeed') and (.='-1' or .='-1.0')))) and
                      not((local-name(..)='SingleAxisHingeJoint') and
                      (((local-name()='anchorPoint' or local-name()='axis') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='maxAngle') and (.= '3.1416' or .= '3.14159' or .= '3.141593' or .= '3.1415926' or .= '3.14159263' or .= '3.141592653')) or
                      ((local-name()='minAngle') and (.='-3.1416' or .='-3.14159' or .='-3.141593' or .='-3.1415926' or .='-3.14159263' or .='-3.141592653')) or
                      ((local-name()='stopBounce') and (.='0' or .='0.0')) or
                      ((local-name()='stopErrorCorrection') and (.='.8' or .='0.8')))) and
                      not((local-name(..)='SliderJoint') and
                      (((local-name()='axis') and (.='0 1 0' or .='0.0 1.0 0.0')) or
                      ((local-name()='maxSeparation' or local-name()='stopErrorCorrection') and (.='1' or .='1.0')) or
                      ((local-name()='minSeparation' or local-name()='sliderForce' or local-name()='stopBounce') and (.='0' or .='0.0')) or
                      ((local-name()='stopErrorCorrection') and (.='1' or .='1.0')))) and
                      not((local-name(..)='UniversalJoint') and
                      (((local-name()='anchorPoint' or local-name()='axis1' or local-name()='axis2') and (.='0 0 0' or .='0.0 0.0 0.0')) or
                      ((local-name()='stop1Bounce' or local-name()='stop2Bounce') and (.='0' or .='0.0')) or
                      ((local-name()='stop1ErrorCorrection' or local-name()='stop2ErrorCorrection') and (.='.8' or .='0.8'))))" />
        <xsl:variable name="notFieldSpace"
                      select="not(local-name(..)='field'  and	(local-name()='space' or local-name()='xml:space')) and
                      not(local-name(..)='Script' and	(local-name()='space' or local-name()='xml:space'))" />
        
        <!-- provide attribute output only if it is not a default value, or if scene has a digital signature -->
        <!-- note that if digital signature is present, all attributes are included (including default values) and
                       order of attributes may change, but that should be OK according to Post Schema Validation Infoset (PSVI) -->
                <xsl:variable name="notDefaultValue" select="
                (count(Signature) > 0) or (count(//ds:Signature) > 0) or
                (
                $notImplicitEvent1 and
                $notImplicitEvent2 and
                $notImplicitEvent3 and
                $notDefaultFieldValue1 and
                $notDefaultFieldValue1a and
                $notDefaultFieldValue2 and
                $notDefaultFieldValue3 and
                $notDefaultFieldValue4 and
                $notDefaultFieldValue5 and
                $notDefaultFieldValue6 and
                $notDefaultFieldValue7 and
                $notDefaultFieldValue8 and
                $notDefaultFieldValue9 and
                $notDefaultCAD         and
                $notDefaultDIS1        and
                $notDefaultDIS2        and
                $notDefaultDIS3        and
                $notDefaultDIS4        and
                $notDefaultGeo         and
                $notDefaultHAnim1      and
                $notDefaultHAnim2      and
                $notDefaultNurbs       and
                $notDefaultGeometry2D  and
                $notDefaultVolume      and
                $notDefaultFollower    and
                $notDefaultShader      and
                $notDefaultRigidBodyPhysics and
                $notDefaultContainerField1  and
                $notDefaultContainerField2  and
                $notDefaultContainerField3  and
                not(local-name()='containerField' and .='') and
                not(local-name()='class' and .='') and
                $notFieldSpace and
                not(contains(local-name(),'set_')) and
                not(contains(local-name(),'_changed')) and
                .)" />
        <!-- debug
        <xsl:message>
            <xsl:value-of select="local-name(..)"/>
            <xsl:text> @</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>=</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>, isDefaultValue: </xsl:text>
            <xsl:value-of select="not($notDefaultValue)"/>
        </xsl:message> -->
        
        <xsl:if test="$notDefaultValue or not($stripDefaultAttributes='true') or ((local-name()='name') and not(/AllX3dElementsAttributes)) or
                      ((local-name(..)='ROUTE') or (local-name(..)='field')   or (local-name(..)='fieldValue'))"> <!-- must haves -->
            <xsl:value-of select="."/> <!-- return non-default value, empty otherwise if $stripDefaultAttributes=false -->
        </xsl:if>
        
    </xsl:template> <!-- end name="not-default-attribute-value" -->
    <xsl:template name="attribute-type"> <!-- rule to determine attribute type -->
	
		<!-- Note:  these rules are adapted from X3dToVrml97.xslt so be sure to apply any updates in both stylesheets -->
		<xsl:variable name="attributeName"       select="local-name()"/>
		<xsl:variable name="parentElementName"   select="local-name(..)"/>
		<xsl:variable name="normalizeSpaceValue" select="normalize-space(.)"/>
		<xsl:variable name="localFieldType"      select="normalize-space(../@type)"/> <!-- locally defined field -->
		<xsl:choose>
		  <!-- SFString -->
		  <xsl:when test="($localFieldType='SFString')          or
                          ($attributeName='DEF')                or ($attributeName='USE') or
                          ($attributeName='name')               or
                          ($attributeName='class')              or
                          ($attributeName='description')        or
                          ($attributeName='address')            or
                          ($attributeName='language')           or
                          ($attributeName='marking')            or
                          ($attributeName='multicastAddress')   or
                          ($attributeName='networkMode')        or
                          ($attributeName='reference')          or
					      (starts-with($parentElementName,'field')         and (($attributeName='accessType') or ($attributeName='type')       or ($attributeName='appinfo') or ($attributeName='documentation'))) or
					      (starts-with($parentElementName,'meta')          and (($attributeName='content')    or ($attributeName='http-equiv') or ($attributeName='scheme')  or ($attributeName='dir') or ($attributeName='lang') or ($attributeName='xml:lang'))) or
                          (($parentElementName='component')                and not($attributeName='level')) or
                          (($parentElementName='unit')                     and not($attributeName='conversionFactor')) or
					      ($parentElementName='ArcClose2D'                 and $attributeName='closureType') or
					      ($parentElementName='BlendedVolumeStyle'         and (starts-with($attributeName,'weightFunction') or ($attributeName='magnificationFilter') or ($attributeName='minificationFilter') or ($attributeName='textureCompression'))) or
                          (ends-with($parentElementName,'Fog')             and $attributeName='fogType') or
					      ($parentElementName='HAnimHumanoid'              and $attributeName='version') or
					      (ends-with($parentElementName,'FontStyle')       and $attributeName='style') or
						  ($parentElementName='GeneratedCubeMapTexture'    and $attributeName='update') or
						  ($parentElementName='ParticleSystem'             and $attributeName='geometryType') or
						  (ends-with($parentElementName,'PickSensor')      and ($attributeName='intersectionType' or $attributeName='matchCriterion' or $attributeName='sortOrder')) or
						  ($parentElementName='ProjectionVolumeStyle'      and $attributeName='type') or
						  ($parentElementName='ShadedVolumeStyle'          and $attributeName='phaseFunction') or
					      ($parentElementName='ShaderPart'                 and $attributeName='type') or
					      ($parentElementName='ShaderProgram'              and $attributeName='type') or
					      ($parentElementName='TextureCoordinateGenerator' and $attributeName='mode') or
					      ($parentElementName='TextureProperties'          and (starts-with($attributeName,'boundaryMode') or ($attributeName='magnificationFilter') or ($attributeName='minificationFilter') or ($attributeName='textureCompression'))) or
                          ($parentElementName='WorldInfo'                  and $attributeName='title') or
                          ($parentElementName='XvlShell'                   and $attributeName='shellType')">
			  <xsl:text>SFString</xsl:text>
		  </xsl:when>
		  <!-- Statements: xs:integer as SFInt32 - TODO schema/spec change? -->
		  <xsl:when test="($localFieldType='SFInt32')           or 
                          (($parentElementName='component')                and $attributeName='level')">
			  <xsl:text>SFInt32</xsl:text>
		  </xsl:when>
		  <xsl:when test="($localFieldType='SFDouble')          or 
                          ($parentElementName='unit'      and $attributeName='conversionFactor')">
			  <xsl:text>SFDouble</xsl:text>
		  </xsl:when>
		  <!-- X3D statements (i.e. not nodes): xs:string (including X3D version attribute) -->
		  <xsl:when test="($attributeName='class')       or
                          ($parentElementName='X3D')     or ($parentElementName='ROUTE')   or ($parentElementName='meta')    or
					      ($parentElementName='EXPORT')  or ($parentElementName='IMPORT')  or ($parentElementName='connect')">
			  <!-- includes X3D version. field/fieldValue type logic handled separately -->
			  <xsl:text>xs:string</xsl:text> 
		  </xsl:when>
		  <!-- MFString (some are also enumerations) -->
		  <xsl:when test="
					($localFieldType='MFString')   or 
                    ($attributeName='url') or contains($attributeName,'Url') or
					($attributeName='forceOutput') or
					($attributeName='objectType')  or
					($parentElementName='Anchor' and $attributeName='parameter') or
					($parentElementName='CollisionCollection' and $attributeName='appliedParameters') or
					($parentElementName='Contact' and $attributeName='appliedParameters') or
					(ends-with($parentElementName,'FontStyle') and ($attributeName='family' or $attributeName='justify')) or
					(starts-with($parentElementName,'Geo') and ($attributeName='geoSystem')) or
					($parentElementName='GeoMetadata' and $attributeName='summary') or
					($parentElementName='GeoViewpoint' and contains($attributeName,'navType')) or
					($parentElementName='HAnimHumanoid' and $attributeName='info') or
					($parentElementName='Layout' and ($attributeName='align' or $attributeName='offsetUnits' or $attributeName='scaleMode' or $attributeName='sizeUnits')) or
					($parentElementName='MetadataString' and $attributeName='value') or
					($parentElementName='MultiTexture' and ($attributeName='function' or $attributeName='mode' or $attributeName='source')) or
					($parentElementName='NavigationInfo' and ($attributeName='type' or $attributeName='transitionType')) or
					($parentElementName='Text' and $attributeName='string') or
					($parentElementName='UniversalJoint' and $attributeName='forceOutput') or
					($parentElementName='WorldInfo' and $attributeName='info')">
			  <xsl:text>MFString</xsl:text>
		  </xsl:when>
		  <!-- SFBool -->
		  <xsl:when test="
					($localFieldType='SFBool')  or 
                    ($attributeName='activate') or
					($attributeName='ccw')      or
					($attributeName='closed')   or
					($attributeName='convex')   or
					($attributeName='colorPerVertex') or
					($attributeName='enabled')  or
					($attributeName='global')   or
					($attributeName='normalPerVertex') or
					($attributeName='on')       or
					($attributeName='loop')     or
					($attributeName='normalizeVelocity') or
					($attributeName='rtpHeaderExpected') or
					($attributeName='solid') or
					($attributeName='uClosed') or ($attributeName='vClosed') or
					($parentElementName='AudioClip' and $attributeName='loop') or
					($parentElementName='Collision' and $attributeName='enabled') or
					($parentElementName='CollisionSpace' and $attributeName='useGeometry') or
					($parentElementName='Cone' and ($attributeName='side' or $attributeName='bottom')) or
					($parentElementName='Cylinder' and ($attributeName='side' or $attributeName='bottom' or $attributeName='top')) or
					($parentElementName='CylinderSensor' and $attributeName='autoOffset') or
					($parentElementName='EspduTransform' and ($attributeName='fired1' or $attributeName='fired2')) or
					($parentElementName='Extrusion' and ($attributeName='beginCap' or $attributeName='endCap')) or
					($parentElementName='FillProperties' and ($attributeName='filled' or $attributeName='hatched')) or
					(ends-with($parentElementName,'FontStyle') and ($attributeName='horizontal' or $attributeName='leftToRight' or $attributeName='topToBottom')) or
					($parentElementName='GeoInline' and $attributeName='load') or
					($parentElementName='GeoOrigin' and $attributeName='rotateYUp') or
					($parentElementName='GeoViewpoint' and $attributeName='headlight') or
					($parentElementName='ImageTexture' and ($attributeName='repeatS' or $attributeName='repeatT')) or
					($parentElementName='Inline' and ($attributeName='load')) or
					(ends-with($parentElementName,'Layer') and ($attributeName='isPickable')) or
					($parentElementName='LineProperties' and ($attributeName='applied')) or
					($parentElementName='LOD' and ($attributeName='forceTransitions')) or
					($parentElementName='MotorJoint' and $attributeName='autoCalc') or
					($parentElementName='MovieTexture' and ($attributeName='repeatS' or $attributeName='repeatT' or $attributeName='loop')) or
					($parentElementName='NurbsPatchSurface' and $attributeName='closedSurface') or
					($parentElementName='ParticleSystem' and $attributeName='createParticles') or
					($parentElementName='VolumeEmitter' and $attributeName='internal') or
					($parentElementName='PickableGroup' and $attributeName='pickable') or
					($parentElementName='PixelTexture' and ($attributeName='repeatS' or $attributeName='repeatT')) or
					($parentElementName='NavigationInfo' and $attributeName='headlight') or
					($parentElementName='PlaneSensor' and $attributeName='autoOffset') or
					($parentElementName='RigidBody' and ($attributeName='autoDamp' or $attributeName='autoDisable' or $attributeName='fixed' or $attributeName='useFiniteRotation' or $attributeName='useGlobalGravity')) or
					($parentElementName='RigidBodyCollection' and ($attributeName='autoDisable' or $attributeName='preferAccuracy')) or
					($parentElementName='SphereSensor' and $attributeName='autoOffset') or
					($parentElementName='StringSensor' and $attributeName='deletionAllowed') or
					($parentElementName='Script' and ($attributeName='directOutput' or $attributeName='mustEvaluate')) or
					($parentElementName='ShadedVolumeStyle' and ($attributeName='lighting' or $attributeName='shadows')) or
					($parentElementName='Sound' and $attributeName='spatialize') or
					($parentElementName='TextureProperties' and $attributeName='generateMipMaps') or
					($parentElementName='TimeSensor' and $attributeName='loop') or
					($parentElementName='TwoSidedMaterial' and $attributeName='separateBackColor') or
					(ends-with($parentElementName,'Viewpoint') and ($attributeName='jump' or $attributeName='retainUserOffsets')) or
					($parentElementName='VolumeEmitter' and $attributeName='internal')">
			  <xsl:text>SFBool</xsl:text>
		  </xsl:when>
		  <!-- MFBool -->
		  <xsl:when test="
					($localFieldType='MFBool')  or 
                    (contains($parentElementName,'BooleanSequencer') and $attributeName='keyValue') or
					($parentElementName='CADLayer'                   and $attributeName='visible') or
					($parentElementName='MetadataBoolean'            and $attributeName='value') or
					($parentElementName='SegmentedVolumeData'        and $attributeName='segmentEnabled') or
					($parentElementName='XvlShell'                   and ($attributeName='faceEmpty' or $attributeName='faceHidden'))">
			  <xsl:text>MFBool</xsl:text>
		  </xsl:when>
		  <!-- SFColor -->
		  <xsl:when test="
					($localFieldType='SFColor')  or 
                    ($parentElementName='CartoonVolumeStyle' and ($attributeName='orthogonalColor' or $attributeName='parallelColor')) or
					($parentElementName='ColorChaser' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='ColorDamper' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					(contains($parentElementName,'Light') and $attributeName='color') or
					($parentElementName='FillProperties' and ($attributeName='hatchColor')) or
					(contains($parentElementName,'Fog') and $attributeName='color') or
					(contains($parentElementName,'Material') and contains($attributeName,'Color')) or
					($parentElementName='MultiTexture' and $attributeName='color')">
			  <xsl:text>SFColor</xsl:text>
		  </xsl:when>
		  <!-- SFColorRGBA -->
		  <xsl:when test="
					($localFieldType='SFColorRGBA')  or 
                    ($parentElementName='EdgeEnhancementVolumeStyle' and $attributeName='edgeColor') or
					($parentElementName='TextureProperties' and $attributeName='borderColor') or
					($parentElementName='ToneMappedVolumeStyle' and ($attributeName='coolColor' or $attributeName='warmColor'))">
			  <xsl:text>SFColorRGBA</xsl:text>
		  </xsl:when>
		  <!-- MFColor -->
		  <xsl:when test="
					(($localFieldType='MFColor')  or 
                    $parentElementName='Color' and $attributeName='color') or
					($parentElementName='ColorInterpolator' and $attributeName='keyValue') or
					(ends-with($parentElementName,'Background') and ($attributeName='groundColor' or $attributeName='skyColor'))">
			  <xsl:text>MFColor</xsl:text>
		  </xsl:when>
		  <!-- MFColorRGBA -->
		  <xsl:when test="
					($localFieldType='MFColorRGBA')  or 
                    ($parentElementName='ColorRGBA' and $attributeName='color')">
			  <xsl:text>MFColorRGBA</xsl:text>
		  </xsl:when>
		  <!-- SFImage -->
		  <xsl:when test="
					($localFieldType='SFImage')  or 
                    ($parentElementName='PixelTexture' and $attributeName='image')">
			  <xsl:text>SFImage</xsl:text>
		  </xsl:when>
		  <!-- no MFImage attributes -->
		  <!-- SFDouble --> <!-- precedes SFFloat since some fields are different than usual -->
		  <xsl:when test="
					($localFieldType='SFDouble')  or 
                    ($parentElementName='GeoElevationGrid' and (($attributeName='creaseAngle') or ($attributeName='xSpacing') or ($attributeName='zSpacing')))">
			  <xsl:text>SFDouble</xsl:text>
		  </xsl:when>
		  <!-- MFDouble -->
		  <xsl:when test="
					($localFieldType='MFDouble')  or 
                    ($parentElementName='GeoElevationGrid'   and $attributeName='height') or
					($parentElementName='MetadataDouble'     and $attributeName='value')  or
					(starts-with($parentElementName,'Nurbs') and (($attributeName='knot') or ($attributeName='weight') or contains($attributeName,'Knot')))">
			  <xsl:text>MFDouble</xsl:text>
		  </xsl:when>
		  <!-- SFFloat -->
		  <xsl:when test="
					($localFieldType='SFFloat')  or 
                    ($attributeName='ambientIntensity') or
					($attributeName='intensity')        or
					($attributeName='creaseAngle')      or
                    ($attributeName='radius')           or ($attributeName='innerRadius') or ($attributeName='outerRadius') or
                    ($attributeName='startAngle')       or ($attributeName='endAngle') or
                    ($attributeName='tolerance')        or
					($attributeName='transparency')     or
					(starts-with($parentElementName,'Arc') and (contains($attributeName,'Angle') or $attributeName='radius')) or
					($parentElementName='AudioClip' and $attributeName='pitch') or
					($parentElementName='BlendedVolumeStyle' and starts-with($attributeName,'weightConstant')) or
					($parentElementName='BoundaryEnhancementVolumeStyle' and (($attributeName='boundaryOpacity') or ($attributeName='opacityFactor') or ($attributeName='retainedOpacity'))) or
					($parentElementName='Circle2D' and $attributeName='radius') or
					($parentElementName='CollisionCollection' and ($attributeName='bounce' or $attributeName='minBounceSpeed' or $attributeName='softnessConstantForceMix' or $attributeName='softnessErrorCorrection')) or
					($parentElementName='Cone' and ($attributeName='bottomRadius' or $attributeName='height')) or
					($parentElementName='Contact' and ($attributeName='bounce' or $attributeName='depth' or $attributeName='minBounceSpeed' or $attributeName='softnessConstantForceMix' or $attributeName='softnessErrorCorrection')) or
					($parentElementName='Cylinder' and ($attributeName='radius' or $attributeName='height')) or
					($parentElementName='CylinderSensor' and ($attributeName='diskAngle' or $attributeName='maxAngle' or $attributeName='minAngle' or $attributeName='offset')) or
					($parentElementName='Disk2D' and contains($attributeName,'Radius')) or
					($parentElementName='DoubleAxisHingeJoint' and (starts-with($attributeName,'desiredAngularVelocity') or starts-with($attributeName,'max') or $attributeName='minAngle1' or starts-with($attributeName,'stop') or starts-with($attributeName,'suspension'))) or
					($parentElementName='EdgeEnhancementVolumeStyle' and $attributeName='gradientThreshold') or
					(contains($parentElementName,'ElevationGrid') and ($attributeName='xSpacing' or $attributeName='zSpacing')) or
					(ends-with($parentElementName,'Emitter') and ($attributeName='angle' or $attributeName='speed' or $attributeName='variation' or $attributeName='mass' or $attributeName='surfaceArea')) or
					($parentElementName='EspduTransform' and $attributeName='firingRange') or
					(ends-with($parentElementName,'Fog') and $attributeName='visibilityRange') or
					($parentElementName='FontStyle' and ($attributeName='size' or $attributeName='spacing')) or
					($parentElementName='GeoElevationGrid' and $attributeName='yScale') or
					($parentElementName='GeoLOD' and $attributeName='range') or
					($parentElementName='GeoViewpoint' and $attributeName='speedFactor') or
					($parentElementName='HAnimDisplacer' and $attributeName='weight') or
					($parentElementName='HAnimSegment' and $attributeName='mass') or
					($parentElementName='IsoSurfaceVolumeData' and ($attributeName='contourStepSize' or $attributeName='surfaceTolerance')) or
					($parentElementName='LineProperties'   and ($attributeName='linewidthScaleFactor')) or
					($parentElementName='Material'         and ($attributeName='ambientIntensity'     or $attributeName='shininess'     or $attributeName='transparency')) or
					($parentElementName='ParticleSystem'   and ($attributeName='lifetimeVariation' or $attributeName='particleLifetime')) or
					($parentElementName='TwoSidedMaterial' and ($attributeName='backAmbientIntensity' or $attributeName='backShininess' or $attributeName='backTransparency')) or
					($parentElementName='MotorJoint'       and (starts-with($attributeName,'axis') or starts-with($attributeName,'stop'))) or
					($parentElementName='MovieTexture'     and ($attributeName='pitch' or $attributeName='speed')) or
					($parentElementName='MultiTexture'     and $attributeName='alpha') or
					($parentElementName='NavigationInfo'   and ($attributeName='speed' or $attributeName='visibilityLimit' or $attributeName='transitionTime')) or
					($parentElementName='NurbsSet' and $attributeName='tessellationScale') or
					($parentElementName='PointLight' and $attributeName='radius') or
					($parentElementName='ProjectionVolumeStyle' and $attributeName='intensityThreshold') or
					($parentElementName='ReceiverPdu' and $attributeName='receivedPower') or
					($parentElementName='RigidBody' and ($attributeName='angularDampingFactor' or starts-with($attributeName,'disable') or $attributeName='linearDampingFactor' or $attributeName='mass')) or
					($parentElementName='RigidBodyCollection' and ($attributeName='constantForceMix' or $attributeName='contactSurfaceThickness' or starts-with($attributeName,'disable') or $attributeName='errorCorrection' or $attributeName='maxCorrectionSpeed')) or
					($parentElementName='ScalarChaser' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='ScalarDamper' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='ScreenFontStyle' and ($attributeName='pointSize' or $attributeName='spacing')) or
					($parentElementName='SilhouetteEnhancementVolumeStyle' and starts-with($attributeName,'silhouette')) or
					($parentElementName='SingleAxisHingeJoint' and ($attributeName='maxAngle' or $attributeName='minAngle' or $attributeName='stopBounce' or $attributeName='stopErrorCorrection')) or
					($parentElementName='SliderJoint' and ($attributeName='maxSeparation' or $attributeName='minSeparation' or $attributeName='sliderForce' or $attributeName='stopBounce' or $attributeName='stopErrorCorrection')) or
					($parentElementName='SpotLight' and ($attributeName='radius' or $attributeName='cutOffAngle' or $attributeName='beamWidth')) or
					($parentElementName='Sound' and ($attributeName='maxBack' or $attributeName='minBack' or $attributeName='maxFront' or $attributeName='minFront' or $attributeName='priority')) or
					($parentElementName='Sphere' and $attributeName='radius') or
					($parentElementName='Text' and $attributeName='maxExtent') or
					($parentElementName='TextureProperties' and ($attributeName='anisotropicDegree' or $attributeName='texturePriority')) or
					($parentElementName='TextureTransform' and $attributeName='rotation') or
					($parentElementName='TransmitterPdu' and ($attributeName='power' or $attributeName='transmitFrequencyBandwidth')) or
					($parentElementName='UniversalJoint' and starts-with($attributeName,'stop')) or
					(contains($parentElementName,'Viewpoint') and $attributeName='fieldOfView') or
					($parentElementName='WindPhysicsModel'    and ($attributeName='gustiness' or $attributeName='speed' or $attributeName='turbulence'))">
			  <xsl:text>SFFloat</xsl:text>
		  </xsl:when>
		  <!-- MFFloat -->
		  <xsl:when test="
					($localFieldType='MFFloat')  or 
                    ($attributeName='key')       or
					(contains($parentElementName,'ElevationGrid') and $attributeName='height') or
					(contains($parentElementName,'LOD') and $attributeName='range') or
					(ends-with($parentElementName,'Background') and ($attributeName='groundAngle' or $attributeName='skyAngle')) or
					($parentElementName='EspduTransform' and $attributeName='articulationParameterArray') or
					($parentElementName='FloatVertexAttribute' and $attributeName='value') or
					($parentElementName='FogCoordinate' and $attributeName='depth') or
					($parentElementName='HAnimSisplacer' and $attributeName='weight') or
					($parentElementName='HAnimJoint' and ($attributeName='llimit' or $attributeName='ulimit' or $attributeName='skinCoordWeight' or $attributeName='stiffness')) or
					($parentElementName='HAnimSegment' and $attributeName='momentsOfInertia') or
					($parentElementName='IsoSurfaceVolumeData' and $attributeName='surfaceValues') or
					($parentElementName='Layout' and ($attributeName='offset' or $attributeName='size')) or
					($parentElementName='MetadataFloat' and $attributeName='value') or
					($parentElementName='NavigationInfo' and $attributeName='avatarSize') or
					($parentElementName='NurbsTextureCoordinate' and $attributeName='weight') or
					($parentElementName='ParticleSystem' and ($attributeName='colorKey' or $attributeName='texCoordKey')) or
					($parentElementName='ScalarInterpolator' and $attributeName='keyValue') or
					($parentElementName='SplineScalarInterpolator' and ($attributeName='keyValue' or $attributeName='keyVelocity')) or
					($parentElementName='Text' and $attributeName='length') or
					($parentElementName='TextureCoordinateGenerator' and $attributeName='parameter') or
					($parentElementName='Viewport' and $attributeName='clipBoundary') or
					($parentElementName='XvlShell' and ($attributeName='vertexRound' or $attributeName='edgeRound'))">
			  <xsl:text>MFFloat</xsl:text>
		  </xsl:when>
		  <!-- SFTime -->
		  <xsl:when test="
					($localFieldType='SFTime')        or 
                    ($parentElementName='TimeSensor') or
                    ($attributeName='duration')       or
                    ($attributeName='tau')            or
                    ($attributeName='timestamp')      or
                    ($attributeName='readInterval')   or
                    ($attributeName='writeInterval')  or
                    ($parentElementName='LoadSensor'     and $attributeName='timeOut')  or
                    ($parentElementName='AudioClip'      and ends-with($attributeName,'Time'))  or
                    ($parentElementName='EspduTransform' and ends-with($attributeName,'Time'))  or
                    ($parentElementName='MovieTexture'   and ends-with($attributeName,'Time'))"> 
			  <!-- TimeSensor loop & enabled are caught by SFBool tests, all other TimeSensorfields are SFTime -->
			  <xsl:text>SFTime</xsl:text>
		  </xsl:when>
		  <!-- no MFTime -->
		  <!-- SFVec2f -->
		  <xsl:when test="
					($localFieldType='SFVec2f')  or 
                    ($parentElementName='CollisionCollection' and ($attributeName='frictionCoefficients' or $attributeName='slipFactors' or $attributeName='surfaceSpeed')) or
					($parentElementName='Contact' and ($attributeName='frictionCoefficients' or $attributeName='slipCoefficients' or $attributeName='surfaceSpeed')) or
					($parentElementName='ParticleSystem' and $attributeName='particleSize') or
					($parentElementName='PlaneSensor' and ($attributeName='maxPosition' or $attributeName='minPosition')) or
					($parentElementName='PositionChaser2D' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='PositionDamper2D' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='Rectangle2D' and ($attributeName='size')) or
					($parentElementName='TextureTransform' and ($attributeName='center' or $attributeName='scale' or $attributeName='translation'))">
			  <xsl:text>SFVec2f</xsl:text>
		  </xsl:when>
		  <!-- MFVec2f -->
		  <xsl:when test="
					($localFieldType='MFVec2f')  or 
                    ($parentElementName='EaseInEaseOut' and $attributeName='easeInEaseOut') or
					($parentElementName='Extrusion' and ($attributeName='crossSection' or $attributeName='scale')) or
					(($parentElementName='CoordinateInterpolator2D' or $parentElementName='PositionInterpolator2D') and $attributeName='keyValue') or
					(($parentElementName='ContourPolyline2D' or $parentElementName='Polypoint2D' or $parentElementName='TextureCoordinate') and $attributeName='point') or
					(($parentElementName='NurbsCurve2D' or $parentElementName='NurbsTextureSurface') and $attributeName='controlPoint') or
					(($parentElementName='Polyline2D') and $attributeName='lineSegments') or
					(($parentElementName='SplinePositionInterpolator2D') and ($attributeName='keyValue' or $attributeName='keyVelocity')) or
					($parentElementName='TexCoordChaser2D' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='TexCoordDamper2D' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					(($parentElementName='TriangleSet2D') and $attributeName='vertices')">
			  <xsl:text>MFVec2f</xsl:text>
		  </xsl:when>
		  <!-- SFVec3d -->
		  <xsl:when test="
					($localFieldType='SFVec3d')  or 
                    ($attributeName='geoCenter') or
					($attributeName='geoCoords') or
					($parentElementName='GeoElevationGrid'   and $attributeName='geoGridOrigin') or
					($parentElementName='GeoLOD'             and $attributeName='center') or
					($parentElementName='GeoProximitySensor' and $attributeName='center') or
					($parentElementName='GeoViewpoint'       and ($attributeName='centerOfRotation' or $attributeName='position'))">
			  <xsl:text>MFVec2f</xsl:text>
		  </xsl:when>
		  <!-- MFVec3d -->
		  <xsl:when test="
					($localFieldType='MFVec3d')  or 
                    ($parentElementName='ContourPolyline2D'       and $attributeName='controlPoint') or
					($parentElementName='CoordinateDouble'        and $attributeName='point') or
					($parentElementName='GeoCoordinate'           and $attributeName='point') or
					($parentElementName='GeoPositionInterpolator' and $attributeName='keyValue') or
					($parentElementName='GeoViewpoint'            and contains($attributeName,'position'))">
			  <xsl:text>MFVec3d</xsl:text>
		  </xsl:when>
		  <!-- SFVec3f -->
		  <!-- note TextureTransform tests must precede these default checks -->
		  <xsl:when test="
					($localFieldType='SFVec3f')    or 
                    ($attributeName='anchorPoint') or
					($attributeName='bboxCenter')  or
					($attributeName='bboxSize')    or
					($attributeName='center')      or
					($attributeName='scale')       or
					($attributeName='translation') or
					($parentElementName='Billboard' and $attributeName='axisOfRotation') or
					($parentElementName='Box' and $attributeName='size') or
					(ends-with($parentElementName,'Emitter') and ($attributeName='direction' or $attributeName='position')) or
					($parentElementName='Contact' and ($attributeName='contactNormal' or $attributeName='frictionDirection' or $attributeName='position')) or
					($parentElementName='DirectionalLight' and $attributeName='direction') or
					($parentElementName='DoubleAxisHingeJoint' and ($attributeName='axis1' or $attributeName='axis2')) or
					($parentElementName='EspduTransform' and (ends-with($attributeName,'Location') or $attributeName='linearVelocity' or $attributeName='linearAcceleration' or ends-with($attributeName,'Point'))) or
					($parentElementName='ForcePhysicsModel' and $attributeName='force') or
					($parentElementName='GeoProximitySensor' and $attributeName='size') or
					(starts-with($parentElementName,'HAnim') and ($attributeName='center' or $attributeName='scale' or $attributeName='translation')) or
					($parentElementName='HAnimSegment' and $attributeName='centerOfMass') or
					(contains($parentElementName,'LOD') and $attributeName='center') or
					($parentElementName='MotorJoint' and ($attributeName='motor1Axis' or $attributeName='motor2Axis' or $attributeName='motor3Axis')) or
					($parentElementName='PlaneSensor' and $attributeName='offset') or
					($parentElementName='PositionChaser' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='PositionDamper' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='ProximitySensor' and ($attributeName='center' or $attributeName='size')) or
					($parentElementName='PointLight' and ($attributeName='attenuation' or $attributeName='location')) or
					($parentElementName='RigidBody' and ($attributeName='angularVelocity' or $attributeName='centerOfMass' or $attributeName='finiteRotationAxis' or $attributeName='linearVelocity' or $attributeName='position')) or
					($parentElementName='RigidBodyCollection' and ($attributeName='gravity')) or
					($parentElementName='SingleAxisHingeJoint' and ($attributeName='axis')) or
					($parentElementName='SliderJoint' and ($attributeName='axis')) or
					($parentElementName='Sound' and ($attributeName='direction' or $attributeName='location')) or
					($parentElementName='SpotLight' and ($attributeName='attenuation' or $attributeName='direction' or $attributeName='location')) or
					($parentElementName='Transform' and ($attributeName='center' or $attributeName='scale' or $attributeName='translation')) or
					($parentElementName='TransformSensor' and ($attributeName='size')) or
					($parentElementName='TransmitterPdu' and (ends-with($attributeName,'Location'))) or
					($parentElementName='UniversalJoint' and ($attributeName='axis1' or $attributeName='axis2')) or
					(($parentElementName='Viewpoint' or $parentElementName='OrthoViewpoint') and ($attributeName='position' or $attributeName='centerOfRotation')) or
					($parentElementName='ViewpointGroup'   and $attributeName='size') or
					($parentElementName='VisibilitySensor' and $attributeName='size') or
					(contains($parentElementName,'VolumeData') and $attributeName='dimensions') or
					($parentElementName='WindPhysicsModel' and $attributeName='direction')">
			  <xsl:text>SFVec3f</xsl:text>
		  </xsl:when>
		  <!-- MFVec3f -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($parentElementName='CoordinateChaser' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='CoordinateDamper' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='CoordinateInterpolator'     and $attributeName='keyValue') or
					($parentElementName='NormalInterpolator'         and $attributeName='keyValue') or
					($parentElementName='PositionInterpolator'       and $attributeName='keyValue') or
					($parentElementName='SplinePositionInterpolator' and ($attributeName='keyValue' or $attributeName='keyVelocity')) or
					(contains($parentElementName,'Coordinate') and $attributeName='point') or
					($parentElementName='Extrusion' and $attributeName='spine') or
					($parentElementName='Normal' and $attributeName='vector') or
					($parentElementName='HAnimDisplacer' and $attributeName='displacements') or
					($parentElementName='XvlShell' and ($attributeName='edgeBeginVector' or $attributeName='edgeEndVector'))">
			  <xsl:text>MFVec3f</xsl:text>
		  </xsl:when>
		  <!-- SFVec4f -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($parentElementName='ClipPlane' and $attributeName='plane')">
			  <xsl:text>SFVec4f</xsl:text>
		  </xsl:when>
		  <!-- SFRotation -->
		  <!-- note TextureTransform tests must precede these default checks -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($attributeName='rotation') or
					($attributeName='scaleOrientation') or
					(($parentElementName='CylinderSensor' or $parentElementName='PlaneSensor') and $attributeName='axisRotation') or
					($parentElementName='OrientationChaser' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='OrientationDamper' and ($attributeName='initialDestination' or $attributeName='initialValue')) or
					($parentElementName='RigidBody' and $attributeName='orientation') or
					($parentElementName='SphereSensor' and $attributeName='offset') or
					($parentElementName='Transform' and ($attributeName='rotation' or $attributeName='scaleOrientation')) or
					(contains($parentElementName,'Viewpoint') and $attributeName='orientation') or
					($parentElementName='HAnimJoint' and ($attributeName='limitOrientation' or $attributeName='rotation' or $attributeName='scaleOrientation')) or
					($parentElementName='HAnimSite' and ($attributeName='rotation' or $attributeName='scaleOrientation'))">
			  <xsl:text>SFRotation</xsl:text>
		  </xsl:when>
		  <!-- MFRotation -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($parentElementName='Extrusion' and $attributeName='orientation') or
					(ends-with($parentElementName,'OrientationInterpolator') and $attributeName='keyValue')">
			  <xsl:text>MFRotation</xsl:text>
		  </xsl:when>
		  <!-- MFMatrix3f -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($parentElementName='Matrix3VertexAttribute' and $attributeName='value')">
			  <xsl:text>MFMatrix3f</xsl:text>
		  </xsl:when>
		  <!-- SFMatrix4f -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($parentElementName='TextureTransformMatrix3D' and $attributeName='matrix')">
			  <xsl:text>SFMatrix4f</xsl:text>
		  </xsl:when>
		  <!-- MFMatrix4f -->
		  <xsl:when test="
					(($localFieldType='MFVec3f')    or 
                    $parentElementName='Matrix4VertexAttribute' and $attributeName='value')">
			  <xsl:text>MFMatrix4f</xsl:text>
		  </xsl:when>
		  <!-- MFInt32 --> <!-- must precede MFInt32 -->
		  <xsl:when test="
					($localFieldType='MFVec3f')    or 
                    ($attributeName='colorIndex') or
					($attributeName='coordIndex') or
					($attributeName='normalIndex') or
					($attributeName='texCoordIndex') or
					($attributeName='faceCoordIndex') or
					($attributeName='faceTexCoordIndex') or
					($attributeName='edgeBeginCoordIndex') or
					($attributeName='edgeEndCoordIndex') or
					($attributeName='fanCount') or
					($attributeName='stripCount') or
					($parentElementName='ContourPolyline2D' and $attributeName='index') or
					($parentElementName='EspduTransform' and starts-with($attributeName,'articulationParameter') and ends-with($attributeName,'Array')) or
					($parentElementName='HAnimJoint' and $attributeName='skinCoordIndex') or
					(starts-with($parentElementName,'IndexedTriangle') and $attributeName='index') or
					($parentElementName='IndexedQuadSet'               and $attributeName='index') or
					($parentElementName='IntegerSequencer' and $attributeName='keyValue') or
					($parentElementName='LayerSet' and ($attributeName='order')) or
					($parentElementName='LineSet' and $attributeName='vertexCount') or
					($parentElementName='MetadataInteger' and $attributeName='value') or
					($parentElementName='SignalPdu' and $attributeName='data')">
			  <xsl:text>MFInt32</xsl:text>
		  </xsl:when>
		  <!-- SFInt32 --> <!-- Note that other DIS attibutes must get tested before this, including MFInt32 -->
		  <xsl:when test="
                    ($localFieldType='MFVec3f')    or 
                     ends-with($attributeName,'ID')             or
                    ($attributeName='order')                    or
					($attributeName='uOrder')                   or
					($attributeName='vOrder')                   or
					($attributeName='uDimension')               or
					($attributeName='vDimension')               or
					($parentElementName='DISEntityManager')     or
					($parentElementName='DISEntityTypeMapping') or
					($parentElementName='EspduTransform')       or
					($parentElementName='SignalPdu')            or
					($parentElementName='ReceiverPdu')          or
					($parentElementName='TransmitterPdu')       or
					($parentElementName='CartoonVolumeStyle' and $attributeName='colorSteps') or
					($parentElementName='IntegerTrigger' and $attributeName='integerKey') or
					(contains($parentElementName,'ElevationGrid') and ($attributeName='xDimension' or $attributeName='zDimension')) or
					($parentElementName='FillProperties' and ($attributeName='hatchStyle')) or
					($parentElementName='FloatVertexAttribute' and $attributeName='numComponents') or
					($parentElementName='GeneratedCubeMapTexture' and $attributeName='size') or
					($parentElementName='LayerSet' and ($attributeName='activeLayer')) or
					($parentElementName='LineProperties' and ($attributeName='linetype')) or
					($parentElementName='MotorJoint' and $attributeName='enabledAxe') or
					($parentElementName='ParticleSystem' and $attributeName='maxParticles') or
					($parentElementName='RigidBodyCollection' and $attributeName='iterations') or
					($parentElementName='Switch' and $attributeName='whichChoice') or
					($parentElementName='TextureProperties' and $attributeName='borderWidth') or
					(starts-with($parentElementName,'Nurbs') and ($attributeName='order' or $attributeName='tessellation' or $attributeName='uTessellation' or $attributeName='vTessellation' or $attributeName='uTessellation' or $attributeName='dimension' or $attributeName='UDimension' or $attributeName='vDimension')) or
					($parentElementName='XvlShell' and $attributeName='numberOfDivisions')">
			  <xsl:text>SFInt32</xsl:text>
		  </xsl:when>
		  <xsl:otherwise>
			  <xsl:choose>
				<xsl:when test="($parentElementName='field')">
					<xsl:value-of select="$localFieldType"/>
				</xsl:when>
				<!-- Other statement values require special handling, do not warn here -->
				<xsl:when test="($parentElementName='field')          or ($parentElementName='fieldValue') or contains($parentElementName,'Proto') or
                                ($parentElementName='meta')">
					<xsl:text></xsl:text>
				</xsl:when>
				<xsl:when test="preceding::*[(local-name() = $parentElementName) and (starts-with($parentElementName,'Xvl'))]">
					<!-- avoid repetitious warnings, no message.  TODO fix, test is not trapping properly. -->
					<xsl:text></xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message>
						  <xsl:text>Warning: X3dToJson.xslt attribute type not found for </xsl:text>
						  <xsl:value-of select="$parentElementName"/>
						  <xsl:text> </xsl:text>
						  <xsl:value-of select="$attributeName"/>
					</xsl:message>
				</xsl:otherwise>
			  </xsl:choose>
		  </xsl:otherwise>
		</xsl:choose>
    </xsl:template>
</xsl:stylesheet>
