import json
from MDSRAPP.utils import utils
from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt



# Create your views here.
def hi(request): # statistics
    return render(request, 'MDSRAPP/hi.html')

def intro(request):
    return render(request, 'MDSRAPP/introduction.html')

def ref(request):
    return render(request, 'MDSRAPP/reference.html')

def home(request):
    return render(request, 'MDSRAPP/home.html')

def minJ(request):
    return render(request, 'MDSRAPP/minJ.html')

def maxJ(request):
    return render(request, 'MDSRAPP/maxJ.html')

def meanJ(request):
    return render(request, 'MDSRAPP/meanJ.html')

def minJh(request):
    return render(request, 'MDSRAPP/minJh.html')

def maxJh(request):
    return render(request, 'MDSRAPP/maxJh.html')

def meanJh(request):
    return render(request, 'MDSRAPP/meanJh.html')

def generalJ(request):
    return render(request, 'MDSRAPP/generalJ.html')

def minK(request):
    return render(request, 'MDSRAPP/minK.html')

def maxK(request):
    return render(request, 'MDSRAPP/maxK.html')

def meanK(request):
    return render(request, 'MDSRAPP/meanK.html')

def minKh(request):
    return render(request, 'MDSRAPP/minKh.html')

def maxKh(request):
    return render(request, 'MDSRAPP/maxKh.html')

def meanKh(request):
    return render(request, 'MDSRAPP/meanKh.html')

def generalK(request):
    return render(request, 'MDSRAPP/generalK.html')

def nstar(request):
    return render(request, 'MDSRAPP/nstar.html')

def nstarh(request):
    return render(request, 'MDSRAPP/nstarh.html')

def bDist(request):
    return render(request, 'MDSRAPP/bDist.html')

def graphWaves(request):
    return render(request, 'MDSRAPP/graphCity.html')

@csrf_exempt
def getGraphCities(request):
    tileNumber = int(request.GET.get('tile'))

    context = {"tile" : utils.getCitiesForTile(tileNumber)}
    a = HttpResponse(json.dumps(context))
    return a


@csrf_exempt
def getGraphImages(request):
    tileNumber = int(request.GET.get('tile'))

    context = {"tile" : utils.getGraphImageFilesNames(tileNumber)}
    return HttpResponse(json.dumps(context))