import os
import json
import math
class utils:


    maxTileNumber = 396
    minTileNumber = 201

    maxFiles = 1847
    citiesPerTile = math.floor(maxFiles / 196)

    citiesFolder = "/static/text/cities/"
    graphsFolder = "/static/imgs/graphs/"
    mainFolder = os.path.dirname(os.path.abspath(__file__))

    @staticmethod
    def getCityFilesNames(index_1, index_2):
        print("Curr path: ", utils.mainFolder + utils.citiesFolder)
        fileNames = os.listdir(utils.mainFolder + utils.citiesFolder)
        fileNames = sorted(fileNames)

        return fileNames[index_1 : index_2]


    @staticmethod
    def getCitiesForTile(tileNumber):
        index_1 = (tileNumber - utils.minTileNumber) * utils.citiesPerTile
        index_2 = index_1 + utils.citiesPerTile

        filenames = utils.getCityFilesNames(index_1, index_2)

        cities = []
        for filename in filenames:
            try:
                with open(utils.mainFolder + utils.citiesFolder + filename) as f:
                    data = f.read()

                object = json.loads(data)
                cities.append(object)

            except Exception as e:
                print("Failed to load: ", filename, "\n", e)

        return cities

    @staticmethod
    def getGraphImageFilesNames(tileNumber):
        print("Curr path: ", utils.mainFolder + utils.graphsFolder)

        index_1 = (tileNumber - utils.minTileNumber) * utils.citiesPerTile
        index_2 = index_1 + utils.citiesPerTile

        fileNames = os.listdir(utils.mainFolder + utils.graphsFolder)
        fileNames = sorted(fileNames)

        return fileNames[index_1: index_2]

