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
    
    var txtProducts = XMLToString(xml);
    
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
    copyProducts(txtProducts);
}

function showBasket() {
    var updatesAndProducts = '<root>' + localStorage.products + 
                               '<updates>' + localStorage.updates + '</updates>' +
                              '</root>';
    alert(updatesAndProducts);
    var doc = StringToXML(updatesAndProducts);
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
        finalDocument = xsltProcessor.transformToFragment(resultDocument, document);
        document.getElementById("example").appendChild(finalDocument);
        alert(XMLToString(finalDocument));
    }
}

function selectBasket() {
    window.open("ShopBasket.html");
}

function processCookies() {
    var pairs = document.cookie.split(';');
    var productsBasket = "<root>";
    productCookie = pairs[pairs.length -1];
    products = productCookie.split('=<');
    product = '<' + products[1];
    
    productsBasket = productsBasket + product + '<updates>';
    for (i = 0; i < pairs.length -1; i++) {
        var value = pairs[i].split('=<');
        productsBasket = productsBasket + '<' + value[1];
    }
    productsBasket = productsBasket + "</updates></root>"
    return productsBasket;
}

function StringToXML(text) {
    //text= "<updates>"+text+"</updates>";
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
    if (localStorage.updates) {
        localStorage.updates = localStorage.updates + '<add ID="'+idProd+'" quantity="1"/>';
    } else {
        localStorage.updates = '<add ID="'+idProd+'" quantity="1"/>';
    }
    alert(localStorage.updates);
}

function deleteProduct(idProd) {
    alert(idProd);
    if (localStorage.updates) {
        localStorage.updates = localStorage.updates + '<delete ID="'+idProd+'"/>';
    } else {
        localStorage.updates = '<delete ID="'+idProd+'"/>';
    }
    alert(localStorage.updates);
}

function updateProduct(idProd) {
    alert('here..');
    var id = 'input'+idProd;
    var quantity = document.getElementById(id).value;
    //alert(idProd);
    alert(quantity);
    if (localStorage.updates) {
        localStorage.updates = localStorage.updates + '<update ID="'+idProd+'" quantity="'+ quantity+'"/>';
    } else {
        localStorage.updates = '<update ID="'+idProd+'" quantity="'+ quantity+'"/>';
    }
    alert(localStorage.updates);
}

function copyProducts(txtProd) {
   alert(txtProd);
   if (localStorage.products) {
        localStorage.product = localStorage.products + txtProd;
    } else {
        localStorage.products = txtProd;
    }
}



function XMLToString(xmlDom) {
    var strs = null;
    var doc = xmlDom.documentElement;
    if (doc.xml == undefined) {
        strs = (new XMLSerializer()).serializeToString(xmlDom);
    } else strs = doc.xml;
    return strs;
}

