import { Episode } from "../model/episode/episode";
import { EpisodeItem } from "../model/episode/episode-list-item";
import { InfoApi } from "../model/info-type";
import { Api } from "./config";

type TEpisodeApi = {
  info: InfoApi,
  results: Episode[]
}
const getAll = async (): Promise<EpisodeItem[]> => {
  try {
    const { data } = await Api.get<TEpisodeApi>('/episode');
    return data.results;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
};

const getByName = async (nome?: string): Promise<EpisodeItem[]> => {
  try {
    const param = (nome?.length === 0) ? undefined : nome;
    const { data } = await Api.get<TEpisodeApi>(`/episode/?name=${param}`);
    return data.results;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
};

const getById = async (id: number): Promise<Episode> => {
  try {
    const { data } = await Api.get<Episode>(`/episode/${id}`);
    console.log(data)
    return data;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
}


export const EpisodeService = {
  getAll,
  getByName,
  getById
}