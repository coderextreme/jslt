
			comment("Copyright (c) 2001-2017 held by the author(s).  All rights reserved.\n")
    
			comment("<head>\n")
    
			comment("=======================================================================\n")
    
			let stylesheet = function (ignore
			,stripComments = 
			xsltext("false")
			,stripDefaultAttributes = 
			xsltext("true")
			,indentEnabled = 
			xsltext("true")
			,sourceText = 
			xsltext("strings")
			,traceEnabled = 
			xsltext("false")
			,traceScripts = 
			xsltext("false")
			,updateContent = 
			xsltext("false")
			
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
			
			apply_templates(
				
	    select("")
    
			);
		
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Warning: comments preceding the top-level X3D element are not translated as part of the X3D JSON object file.")
			
			xsltext("")
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("<!--")
			
	    select("")
    
			xsltext("-->")
			
			xsltext("")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Warning: comments following the X3D element are not translated as part of the X3D JSON object file.")
			
			xsltext("")
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("<!--")
			
	    select("")
    
			xsltext("-->")
			
			xsltext("")
			
			}
		
			}
		
			let allContainedCommentsElements=
				
	    select("")
    
			;
			
			apply_templates(
				
	    select("")
    
			);
		
	    select("")
    
			template["trace"](
				
			);
		
			let elementName=
				
	    select("")
    
			;
			
			let parentName=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("{")
			
			} else {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			}
		
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("{")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			xsltext("")
			
			xsltext("\"encoding\":\"UTF-8\",")
			
			}
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			xsltext("{")
			
			}
		
			} else {
			
			xsltext("[")
			
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			template["attributes"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("JSON schema\":\"http://www.web3d.org/specifications/x3d-3.3-JSONSchema.json")
			
			xsltext(",")
			
			}
		
			template["comments-elements-ROUTEs"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"translated\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":")
			
	    select("")
    
			xsltext("")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("},")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"generator\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":\"X3dToJson.xslt, http://www.web3d.org/x3d/stylesheets/X3dToJson.html")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("},")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"warning\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":\"An experimental version of X3D JSON encoding is used for this scene.  Status online at http://www.web3d.org/wiki/index.php/X3D_JSON_Encoding")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			xsltext("}")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("}")
			
			xsltext("")
			
			xsltext("}")
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			} else {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			} else if (
				
	    test("")
    
			) {
			
			process.stderr.write("");
			
			xsltext("Warning: XML Digital Signature not supported in X3D JSON encoding, <ds:Signature/> authentication block ignored.")
			
			} else {
			
			let fieldName=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
			xsltext("IllegalChildNodeFieldNameNotFound")
			
			process.stderr.write("");
			
			xsltext("Error: IllegalChildNodeFieldNameNotFound no containerField or field name found for the X3D JSON object. Check spelling of node.")
			
			xsltext("")
			
			xsltext("$elementName=")
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext(", DEF=")
			
	    select("")
    
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(", USE=")
			
	    select("")
    
			}
		
			xsltext(", $parentName=")
			
	    select("")
    
			xsltext("")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("Please report this error to x3d-public@web3d.org - thanks for your help improving X3D Quality Assurance (QA).")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("is a test scene supporting X3D Quality Assurance (QA).")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			let SFNodeType=
				
	    select("")
    
			;
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			xsltext("-")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("[")
			
			}
		
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("#comment")
			
			} else {
			
			xsltext("")
			
	    select("")
    
			}
		
			xsltext("")
			
			xsltext(":")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			template["attributes"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			template["comments-elements-ROUTEs"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			template["trace"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			xsltext("")
			
			template["print-indent"](
				
			);
		
			apply_templates(
				
	    select("")
    
			);
		
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			}
		
			}
		
			xsltext(",")
			
			}
		
			}
		
			template["trace"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("#comment")
			
	    select("")
    
			xsltext("")
			
			xsltext(":[")
			
			let allCommentsStringArray=
				
	    select("")
    
			;
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			xsltext(",")
			
			}
		
	    select("")
    
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			xsltext(",")
			
			}
		
			let allAttributesString=
				
	    select("")
    
			;
			
			apply_templates(
				
	    select("")
    
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			}
		
			let normalizedValue=
				
	    select("")
    
			;
			
			let notDefaultAttributeValue=
				
	    select("")
    
			;
			
			template["not-default-attribute-value"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			let attributeName=
				
	    select("")
    
			;
			
			let fieldValueName=
				
	    select("")
    
			;
			
			let protoInstanceName=
				
	    select("")
    
			;
			
			let fieldValueType1=
				
	    select("")
    
			;
			
			let fieldValueType2=
				
	    select("")
    
			;
			
			let fieldValueType=
				
	    select("")
    
			;
			
			let containsQuote=
				
	    select("")
    
			;
			
			let containsEscapedQuote=
				
	    select("")
    
			;
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("@")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			let attributeType=
				
	    select("")
    
			;
			
			template["attribute-type"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			let escapespecialcharactersquotesrecurseresult=
				
	    select("")
    
			;
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			let insertcommasrecurseresult=
				
	    select("")
    
			;
			
			template["insert-commas-recurse"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			template["trace"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			template["output-integers"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			template["output-reals"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["output-integers"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["output-reals"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			template["output-reals"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			let normalizedFloats=
				
	    select("")
    
			;
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else {
			
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Error: X3dToJson.xslt converter not finding element-attribute type for")
			
	    select("")
    
			xsltext("")
			
	    select("")
    
			}
		
			}
		
			xsltext(",")
			
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			let elementName=
				
	    select("")
    
			;
			
			let traceMessage=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("contains CDATA source-code text, copied as \"#sourceText\" using \"")
			
	    select("")
    
			xsltext("\" mode")
			
			} else {
			
			xsltext("contains stray text characters: \"")
			
	    select("")
    
			xsltext("")
			
			}
		
			template["trace"](
				
			);
		
			xsltext("")
			
			xsltext("#sourceText")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			let sourceStringText=
				
	    select("")
    
			;
			
			template["escape-quotes-recurse"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			xsltext("")
			
			template["replace-newlines-recurse"](
				
			);
		
			xsltext("")
			
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			xsltext("]")
			
			xsltext("")
			
			} else {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("illegal value for $sourceText=")
			
	    select("")
    
			xsltext(", allowed values are escaped | strings | plaintext.  Using default $sourceText=strings")
			
			}
		
			xsltext("[")
			
			template["split-text-block-into-string-array"](
				
			);
		
			xsltext("")
			
			xsltext("]")
			
			}
		
			} else {
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			}
		
			template["escape-quotes-recurse"](
				
			);
		
			let debugTrace=
				
	    select("")
    
			;
			
			let debugMessage=
				
	    select("")
    
			;
			
			xsltext("[local-name()=")
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("comment")
			
			}
		
			xsltext("]")
			
			let reentry=
				
	    select("")
    
			;
			
	    select("")
    
			xsltext("[inputType=")
			
	    select("")
    
			xsltext("]")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1]")
			
	    select("")
    
			}
		
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1.5]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1.6]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.3 \\ to \\]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.4 \\ to \\]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.5 \" to \\\"]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[3]")
			
	    select("")
    
			}
		
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[3.5]")
			
	    select("")
    
			}
		
			xsltext("")
			
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			template["escape-quotes-recurse"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Error: malformed SFString value has \"\" empty string followed by extra characters:")
			
	    select("")
    
	    select("")
    
			}
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[4]")
			
	    select("")
    
			}
		
			xsltext("")
			
			template["escape-quotes-recurse"](
				
			);
		
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[5]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[6]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext(" ")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[7]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[8]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[9]")
			
	    select("")
    
			}
		
	    select("")
    
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			template["omit-leading-trailing-whitespace"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			template["omit-leading-trailing-whitespace"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			let nextChar=
				
	    select("")
    
			;
			
			let remainder=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("<")
			
			template["escape-less-than-characters-recurse"](
				
			);
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("\n")
			
			template["replace-newlines-recurse"](
				
			);
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("\t")
			
			template["replace-tabs-recurse"](
				
			);
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext(">")
			
			template["escape-greater-than-characters-recurse"](
				
			);
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext("\\\\\"")
			
			template["insert-commas-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(",")
			
			template["insert-commas-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			} else {
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("\",")
			
			template["split-text-block-into-string-array"](
				
			);
		
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			let singleInteger=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			template["hexToDecimal"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			let mostSignificantHexDigit=
				
	    select("")
    
			;
			
			let decimalValueOfHexDigit=
				
	    select("")
    
			;
			
			let result=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			template["hexToDecimal"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			let singleReal=
				
	    select("")
    
			;
			
			template["insert-leading-trailing-zero"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			template["insert-leading-trailing-zero"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(".0e")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(".0E")
			
	    select("")
    
			} else {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			let fullMessage=
				
	    select("")
    
			;
			
			template["print-indent"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("name=")
			
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("DEF=")
			
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("USE=")
			
	    select("")
    
			xsltext("")
			
			}
		
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
	    select("")
    
			}
		
			}
		
			let notImplicitEvent1=
				
	    select("")
    
			;
			
			let notImplicitEvent2=
				
	    select("")
    
			;
			
			let notImplicitEvent3=
				
	    select("")
    
			;
			
			let notDefaultFieldValue1=
				
	    select("")
    
			;
			
			let notDefaultFieldValue1a=
				
	    select("")
    
			;
			
			let notDefaultFieldValue2=
				
	    select("")
    
			;
			
			let notDefaultFieldValue3=
				
	    select("")
    
			;
			
			let notDefaultFieldValue4=
				
	    select("")
    
			;
			
			let notDefaultFieldValue5=
				
	    select("")
    
			;
			
			let notDefaultFieldValue6=
				
	    select("")
    
			;
			
			let notDefaultFieldValue7=
				
	    select("")
    
			;
			
			let notDefaultFieldValue8=
				
	    select("")
    
			;
			
			let notDefaultFieldValue9=
				
	    select("")
    
			;
			
			let notDefaultContainerField1=
				
	    select("")
    
			;
			
			let notDefaultContainerField2=
				
	    select("")
    
			;
			
			let notDefaultContainerField3=
				
	    select("")
    
			;
			
			let notDefaultCAD=
				
	    select("")
    
			;
			
			let notDefaultDIS1=
				
	    select("")
    
			;
			
			let notDefaultDIS2=
				
	    select("")
    
			;
			
			let notDefaultDIS3=
				
	    select("")
    
			;
			
			let notDefaultDIS4=
				
	    select("")
    
			;
			
			let notDefaultGeo=
				
	    select("")
    
			;
			
			let notDefaultHAnim1=
				
	    select("")
    
			;
			
			let notDefaultHAnim2=
				
	    select("")
    
			;
			
			let notDefaultNurbs=
				
	    select("")
    
			;
			
			let notDefaultGeometry2D=
				
	    select("")
    
			;
			
			let notDefaultVolume=
				
	    select("")
    
			;
			
			let notDefaultFollower=
				
	    select("")
    
			;
			
			let notDefaultShader=
				
	    select("")
    
			;
			
			let notDefaultRigidBodyPhysics=
				
	    select("")
    
			;
			
			let notFieldSpace=
				
	    select("")
    
			;
			
			let notDefaultValue=
				
	    select("")
    
			;
			
			if (
				
	    test("")
    
			) {
				
	    select("")
    
			}
		
			let attributeName=
				
	    select("")
    
			;
			
			let parentElementName=
				
	    select("")
    
			;
			
			let normalizeSpaceValue=
				
	    select("")
    
			;
			
			let localFieldType=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFString")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFInt32")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("xs:string")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFString")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFBool")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFBool")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFColor")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFColorRGBA")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFColor")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFColorRGBA")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFImage")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFFloat")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFFloat")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFTime")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec3d")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFRotation")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFRotation")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFMatrix3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFMatrix4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFMatrix4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFInt32")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFInt32")
			
			} else {
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			} else {
			
			process.stderr.write("");
			
			xsltext("Warning: X3dToJson.xslt attribute type not found for")
			
	    select("")
    
			xsltext("")
			
	    select("")
    
			}
		
			}
		
			}
			
			let isTestScene=
				
	    select("")
    
			;
			template["/"] = function (ignore
			
			){
			,
	    select("")
    
			process.stderr.write("");
			
			xsltext("Warning: comments preceding the top-level X3D element are not translated as part of the X3D JSON object file.")
			
			xsltext("")
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("<!--")
			
	    select("")
    
			xsltext("-->")
			
			xsltext("")
			
			}
		
			process.stderr.write("");
			
			xsltext("Warning: comments following the X3D element are not translated as part of the X3D JSON object file.")
			
			xsltext("")
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("<!--")
			
	    select("")
    
			xsltext("-->")
			
			xsltext("")
			
			}
		
			}
		template["comments-elements-ROUTEs"] = function (ignore
			,indent = 
			xsltext("0")
			
			){
			
			apply_templates(
				
	    select("")
    
			);
		
			}
		template["* | comment()"] = function (ignore
			,indent = 
			xsltext("0")
			
			){
			,
	    select("")
    ,
	    select("")
    ,
	    select("")
    ,
	    select("")
    ,
	    select("")
    ,
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("{")
			
			} else {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			}
		
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("{")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			xsltext("")
			
			xsltext("\"encoding\":\"UTF-8\",")
			
			}
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			xsltext("{")
			
			}
		
			} else {
			
			xsltext("[")
			
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			template["attributes"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("JSON schema\":\"http://www.web3d.org/specifications/x3d-3.3-JSONSchema.json")
			
			xsltext(",")
			
			}
		
			template["comments-elements-ROUTEs"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"translated\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":")
			
	    select("")
    
			xsltext("")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("},")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"generator\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":\"X3dToJson.xslt, http://www.web3d.org/x3d/stylesheets/X3dToJson.html")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("},")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("\"@name\":\"warning\",")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("@content\":\"An experimental version of X3D JSON encoding is used for this scene.  Status online at http://www.web3d.org/wiki/index.php/X3D_JSON_Encoding")
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			xsltext("}")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("}")
			
			xsltext("")
			
			xsltext("}")
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			} else {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			} else if (
				
	    test("")
    
			) {
			
			process.stderr.write("");
			
			xsltext("Warning: XML Digital Signature not supported in X3D JSON encoding, <ds:Signature/> authentication block ignored.")
			
			} else {
			
			let fieldName=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("children")
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
			xsltext("IllegalChildNodeFieldNameNotFound")
			
			process.stderr.write("");
			
			xsltext("Error: IllegalChildNodeFieldNameNotFound no containerField or field name found for the X3D JSON object. Check spelling of node.")
			
			xsltext("")
			
			xsltext("$elementName=")
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext(", DEF=")
			
	    select("")
    
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(", USE=")
			
	    select("")
    
			}
		
			xsltext(", $parentName=")
			
	    select("")
    
			xsltext("")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("Please report this error to x3d-public@web3d.org - thanks for your help improving X3D Quality Assurance (QA).")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("is a test scene supporting X3D Quality Assurance (QA).")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			let SFNodeType=
				
	    select("")
    
			;
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			xsltext("-")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("[")
			
			}
		
			}
		
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("#comment")
			
			} else {
			
			xsltext("")
			
	    select("")
    
			}
		
			xsltext("")
			
			xsltext(":")
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("{")
			
			template["attributes"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			template["comments-elements-ROUTEs"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			template["trace"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			xsltext("")
			
			template["print-indent"](
				
			);
		
			apply_templates(
				
	    select("")
    
			);
		
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			}
		
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("}")
			
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		
			if (
				
	    test("")
    
			) {
				
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			}
		
			}
		
			xsltext(",")
			
			}
		
			}
		template["hide/comment()"] = function (ignore
			,indent = 
			xsltext("0")
			,stripComments = 
	    select("")
    
			){
			,
	    select("")
    ,
	    select("")
    ,
	    select("")
    ,
	    select("")
    
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("#comment")
			
	    select("")
    
			xsltext("")
			
			xsltext(":[")
			
			let allCommentsStringArray=
				
	    select("")
    
			;
			
			for(let d in 
				
	    select("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			xsltext(",")
			
			}
		
	    select("")
    
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("]")
			
			xsltext(",")
			
			}
		template["attributes"] = function (ignore
			,indent = 
			xsltext("0")
			
			){
			
			apply_templates(
				
	    select("")
    
			);
		
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			}
		template["@*"] = function (ignore
			,isComment = 
			xsltext("false")
			,indent = 
			xsltext("0")
			
			){
			
			template["not-default-attribute-value"](
				
			);
		
			let attributeName=
				
	    select("")
    
			;
			
			let fieldValueName=
				
	    select("")
    
			;
			
			let protoInstanceName=
				
	    select("")
    
			;
			
			let fieldValueType1=
				
	    select("")
    
			;
			
			let fieldValueType2=
				
	    select("")
    
			;
			
			let fieldValueType=
				
	    select("")
    
			;
			
			let containsQuote=
				
	    select("")
    
			;
			
			let containsEscapedQuote=
				
	    select("")
    
			;
			
			if (
				
	    test("")
    
			) {
				
			xsltext("")
			
			template["print-indent"](
				
			);
		
			xsltext("")
			
			xsltext("@")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			let attributeType=
				
	    select("")
    
			;
			
			template["attribute-type"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			let escapespecialcharactersquotesrecurseresult=
				
	    select("")
    
			;
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			let insertcommasrecurseresult=
				
	    select("")
    
			;
			
			template["insert-commas-recurse"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			template["trace"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			template["output-integers"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			template["output-reals"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["output-integers"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["output-reals"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			template["output-reals"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			let normalizedFloats=
				
	    select("")
    
			;
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			template["insert-commas-recurse"](
				
			);
		
			xsltext("]")
			
			} else {
			
			xsltext("")
			
			template["escape-special-characters-quotes-recurse"](
				
			);
		
			xsltext("")
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Error: X3dToJson.xslt converter not finding element-attribute type for")
			
	    select("")
    
			xsltext("")
			
	    select("")
    
			}
		
			}
		
			xsltext(",")
			
			}
		
			}
		template["text()"] = function (ignore
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			let elementName=
				
	    select("")
    
			;
			
			let traceMessage=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("contains CDATA source-code text, copied as \"#sourceText\" using \"")
			
	    select("")
    
			xsltext("\" mode")
			
			} else {
			
			xsltext("contains stray text characters: \"")
			
	    select("")
    
			xsltext("")
			
			}
		
			template["trace"](
				
			);
		
			xsltext("")
			
			xsltext("#sourceText")
			
	    select("")
    
			xsltext("")
			
			xsltext(":")
			
			let sourceStringText=
				
	    select("")
    
			;
			
			template["escape-quotes-recurse"](
				
			);
		
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			xsltext("")
			
			template["replace-newlines-recurse"](
				
			);
		
			xsltext("")
			
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("[")
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			xsltext("]")
			
			xsltext("")
			
			} else {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("illegal value for $sourceText=")
			
	    select("")
    
			xsltext(", allowed values are escaped | strings | plaintext.  Using default $sourceText=strings")
			
			}
		
			xsltext("[")
			
			template["split-text-block-into-string-array"](
				
			);
		
			xsltext("")
			
			xsltext("]")
			
			}
		
			} else {
			
			}
		template["print-indent"] = function (ignore
			,indent = 
			xsltext("0")
			
			){
			
			xsltext("")
			
			template["print-indent"](
				
			);
		
			}
		template["escape-special-characters-quotes-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			,inputType = 
			xsltext("false")
			
			){
			,
	    select("")
    ,
	    select("")
    
			}
		template["escape-quotes-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			,inputType = 
			xsltext("false")
			
			){
			
			xsltext("[local-name()=")
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("comment")
			
			}
		
			xsltext("]")
			
			let reentry=
				
	    select("")
    
			;
			
	    select("")
    
			xsltext("[inputType=")
			
	    select("")
    
			xsltext("]")
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1]")
			
	    select("")
    
			}
		
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1.5]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[1.6]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.3 \\ to \\]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.4 \\ to \\]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[2.5 \" to \\\"]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[3]")
			
	    select("")
    
			}
		
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[3.5]")
			
	    select("")
    
			}
		
			xsltext("")
			
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			template["escape-quotes-recurse"](
				
			);
		
			}
		
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("Error: malformed SFString value has \"\" empty string followed by extra characters:")
			
	    select("")
    
	    select("")
    
			}
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[4]")
			
	    select("")
    
			}
		
			xsltext("")
			
			template["escape-quotes-recurse"](
				
			);
		
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[5]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[6]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext(" ")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[7]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[8]")
			
	    select("")
    
			}
		
	    select("")
    
			xsltext("\\\"")
			
			template["escape-quotes-recurse"](
				
			);
		
			} else {
			
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
			xsltext("[9]")
			
	    select("")
    
			}
		
	    select("")
    
			}
		template["omit-leading-trailing-whitespace"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			template["omit-leading-trailing-whitespace"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			template["omit-leading-trailing-whitespace"](
				
			);
		
			} else {
			
	    select("")
    
			}
		template["escape-backslash-characters-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			let nextChar=
				
	    select("")
    
			;
			
			let remainder=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			} else {
			
			xsltext("\\")
			
	    select("")
    
			template["escape-backslash-characters-recurse"](
				
			);
		
			}
		
			}
		template["escape-less-than-characters-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("<")
			
			template["escape-less-than-characters-recurse"](
				
			);
		
			}
		template["replace-newlines-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("\n")
			
			template["replace-newlines-recurse"](
				
			);
		
			}
		template["replace-tabs-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext("\t")
			
			template["replace-tabs-recurse"](
				
			);
		
			}
		template["escape-greater-than-characters-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			xsltext(">")
			
			template["escape-greater-than-characters-recurse"](
				
			);
		
			}
		template["insert-commas-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			,inputType = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext("\\\\\"")
			
			template["insert-commas-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(",")
			
			template["insert-commas-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else {
			
	    select("")
    
			}
		template["split-text-block-into-string-array"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("")
			
			} else {
			
			xsltext("")
			
			xsltext("")
			
	    select("")
    
			xsltext("\",")
			
			template["split-text-block-into-string-array"](
				
			);
		
			}
		template["output-integers"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			let singleInteger=
				
	    select("")
    
			;
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
			template["hexToDecimal"](
				
			);
		
			} else {
			
	    select("")
    
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		template["hexToDecimal"] = function (ignore
			,hexDigits = ,decimalValue = 
			){
			
			} else if (
				
	    test("")
    
			) {
			
			template["hexToDecimal"](
				
			);
		
			} else {
			
	    select("")
    
			}
		template["output-reals"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			let singleReal=
				
	    select("")
    
			;
			
			template["insert-leading-trailing-zero"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
			xsltext(",")
			
			}
		
			}
		template["insert-leading-trailing-zero"] = function (ignore
			,inputReal = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			template["insert-leading-trailing-zero"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(".0e")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			xsltext(".0E")
			
	    select("")
    
			} else {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			}
		template["insert-leading-trailing-zeroes-recurse"] = function (ignore
			,inputString = 
			xsltext("")
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else if (
				
	    test("")
    
			) {
			
			xsltext("-0")
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			xsltext("")
			
			template["insert-leading-trailing-zeroes-recurse"](
				
			);
		
			} else {
			
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			xsltext("0")
			
			}
		
			}
		template["trace"] = function (ignore
			,message = 
			xsltext("")
			,element = 
			xsltext("")
			,name = 
			xsltext("")
			,DEF = 
			xsltext("")
			,USE = 
			xsltext("")
			,indent = 
			xsltext("0")
			,traceEnabled = 
			){
			
			let fullMessage=
				
	    select("")
    
			;
			
			template["print-indent"](
				
			);
		
			if (
				
	    test("")
    
			) {
				
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("name=")
			
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("DEF=")
			
	    select("")
    
			xsltext("")
			
			}
		
			if (
				
	    test("")
    
			) {
				
			xsltext("USE=")
			
	    select("")
    
			xsltext("")
			
			}
		
	    select("")
    
			if (
				
	    test("")
    
			) {
				
			process.stderr.write("");
			
	    select("")
    
			}
		
			}
		template["not-default-attribute-value"] = function (ignore
			
			){
			
	    select("")
    
			}
		template["attribute-type"] = function (ignore
			
			){
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFString")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFInt32")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("xs:string")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFString")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFBool")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFBool")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFColor")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFColorRGBA")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFColor")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFColorRGBA")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFImage")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFDouble")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFFloat")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFFloat")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFTime")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec2f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec3d")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFVec3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFVec4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFRotation")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFRotation")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFMatrix3f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFMatrix4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFMatrix4f")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("MFInt32")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("SFInt32")
			
			} else {
			
			if (false) {
			
			} else if (
				
	    test("")
    
			) {
			
	    select("")
    
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			} else if (
				
	    test("")
    
			) {
			
			xsltext("")
			
			} else {
			
			process.stderr.write("");
			
			xsltext("Warning: X3dToJson.xslt attribute type not found for")
			
	    select("")
    
			xsltext("")
			
	    select("")
    
			}
		
			}
		