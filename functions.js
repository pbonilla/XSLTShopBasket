function loadXMLDoc(filename) {
    if (window.ActiveXObject) {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } else {
        xhttp = new XMLHttpRequest();
    }
    xhttp.open("GET", filename, false);
    try {
        xhttp.responseType = "msxml-document"
    }
    catch (err) {
    }
    // Helping IE11
    xhttp.send("");
    return xhttp.responseXML;
}

function displayResult(xmlPath, xslPath) {
    xml = loadXMLDoc(xmlPath);
    xsl = loadXMLDoc(xslPath);
    
    // code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document") {
        ex = xml.transformNode(xsl);
        document.getElementById("example").innerHTML = ex;
    } else if (document.implementation && document.implementation.createDocument) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml, document);
        document.getElementById("example").appendChild(resultDocument);
    }
}

function showBasket() {
    var str = processCookies();
    var doc = StringToXML(str);
    var sera = XMLToString(doc);
    alert(sera);
    var xsl = loadXMLDoc('shopBasket1.xsl');
    if (document.implementation && document.implementation.createDocument) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToDocument(doc);
        alert(XMLToString(resultDocument));
    }
    var xsl1 = loadXMLDoc('FinalProcess.xsl');
    if (document.implementation && document.implementation.createDocument) {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl1);
        finalDocument = xsltProcessor.transformToFragment(resultDocument,document);
        document.getElementById("example").appendChild(finalDocument);
        alert(XMLToString(finalDocument));
    }
}

function selectBasket() {
    window.open("ShopBasket.html");
}

function processCookies() {
    var pairs = document.cookie.split(';');
    var products = "";
    for (i = 0; i < pairs.length; i++) {
        var value = pairs[i].split('=<');
        products = products + '<' + value[1];
    }
    return products;
}

function StringToXML(text) {
    text= "<updates>"+text+"</updates>";
    if (window.ActiveXObject) {
        var doc = new ActiveXObject('Microsoft.XMLDOM');
        doc.async = 'false';
        doc.loadXML(text);
    } else {
        var parser = new DOMParser();
        var doc = parser.parseFromString(text, 'text/xml');
    }
    return doc;
}

function addProduct(idProd) {
    alert(idProd);
    document.cookie = 'cookie' + idProd + '=' + '<add ID="' + idProd + '" quantity="1"></add>';
    alert(document.cookie);
}


function XMLToString(xmlDom) {
    var strs = null;
    var doc = xmlDom.documentElement;
    if (doc.xml == undefined) {
        strs = (new XMLSerializer()).serializeToString(xmlDom);
    } else strs = doc.xml;
    return strs;
}